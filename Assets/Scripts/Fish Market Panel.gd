extends Control

var column_size = 5
var graph_limit = 1920
var graph_start = 425
var tick_time = .4		#time between ticks

#limits for graph
var lower_limit = 590
var upper_limit = 5

var min_val = 0
var max_val = 1

var curr_price = 1
var prev_price = 1

var multiplier = 1.0

var open = false	#is market open

var curr_fish_name = ""

onready var player = get_parent().get_parent().get_node("Player")
onready var inventory = get_parent().get_node("Escape").get_node("Inventory")

enum direction {
	UP,
	DOWN
}

func move_horizontally(p_direction, limit_difference):
	var num = 0
	if p_direction == direction.UP:
		num = -1
	elif p_direction == direction.DOWN:
		num = 1
		
	for i in range($FishLine.get_point_count()):
		var point_pos = $FishLine.get_point_position(i)
		point_pos.y = point_pos.y + limit_difference * num
		$FishLine.set_point_position(i,point_pos)

func move_points_horizontally(pointY):		#in case of y values dipping below the screen
	if pointY > lower_limit:
		
		var limit_difference = pointY - lower_limit
		pointY = lower_limit

		move_horizontally(direction.UP,limit_difference)
			
	elif pointY < upper_limit:
		
		var limit_difference = upper_limit - pointY
		pointY = upper_limit
		
		move_horizontally(direction.DOWN, limit_difference)
			
	return pointY

func move_back():
	for i in range($FishLine.get_point_count()):
		var point_pos = $FishLine.get_point_position(i)
		point_pos.x = point_pos.x - column_size		#move point back one tick
		$FishLine.set_point_position(i,point_pos)	

func move_points_back(pointX):		#in case of graph reaching the end of the screen
	if pointX >= graph_limit:
		
		pointX = graph_limit	#ensure points do not exceed graph
		
		$FishLine.remove_point(0) 
		
		move_back()

	return pointX

func close_market():
	open = false

func calc_price_change(max_change, min_change):
	var price_change = rand_range(curr_price * min_change, curr_price * max_change)
	return price_change

func large_rise():
	return calc_price_change(0.25,0.1)

func large_dip():
	return calc_price_change(0.3,0.1)

func small_rise():
	return calc_price_change(0.1,0.05)
	
func small_dip():
	return calc_price_change(0.1,0.01)
	
func market_trends():
	var rand = randi() % 9
	if rand >= 0 and rand <= 2:
		return curr_price - small_dip()
	elif rand >= 3 and rand <= 7:
		return curr_price + small_rise()
	elif rand == 8:
		return curr_price - large_dip()
	elif rand == 9:
		return curr_price + large_rise()

func calc_price():
	var val = market_trends()
	if val <= min_val:
		curr_price = min_val
	if val >= max_val:
		curr_price = max_val
	else:
		curr_price = val
	$FishInformation.change_price("Price: " + str(val))
	return val

func convert_price_to_graph(val):
	var difference = lower_limit - val	
	return upper_limit + difference
	
func fit_point(p):		#function currently not in use
	if p > prev_price:
		p = p * (multiplier * 0.1)
	elif p < prev_price:
		p = p * multiplier
	return p

func get_point(i):		#return point on graph
	var pointX = graph_start + i * column_size		#x value of point in the graph
	var pointY = convert_price_to_graph(calc_price())
	
	pointX = move_points_back(pointX)
	pointY = move_points_horizontally(pointY) 

	var point_pos = Vector2(pointX, pointY)
	
	return point_pos
	

func open_market():
	$FishLine.clear_points()
	
	var i = 0
	open = true
	while open == true:
		
		var point_pos = get_point(i)
		
		yield(get_tree().create_timer(tick_time), "timeout")	#wait
		
		$FishLine.add_point(point_pos)
		
		i += 1

func calc_multi():
	if max_val < lower_limit:
		return lower_limit / max_val
	elif max_val > lower_limit:
		return 1

func change_fish(fish):		#change the fish the graph 
	close_market()
	yield(get_tree().create_timer(tick_time), "timeout")	#wait
	open_market()
	min_val = fish.min_price
	max_val = fish.max_price
	
	multiplier = calc_multi()
	
	curr_price = randi() % max_val + min_val
	prev_price = curr_price
	
	curr_fish_name = fish.name
	
	$FishInformation.change_amount("amount: " + str(get_fish_amount()))

func get_fish_amount():
	for i in inventory.find_inventory():
		if i.get_name() == curr_fish_name:
			return i.get_amount()
	return 0

func check_fish_amount(amount):
	var count = 0
	if get_fish_amount() >= amount:
		return true
	return false

func find_fish():
	for i in inventory.find_inventory():
		if i.get_name() == curr_fish_name:
			return i
	
func change_labels():
	$FishInformation.change_money(player.get_money())
	$FishInformation.change_amount("amount: " + str(get_fish_amount()))
	
func set_money_and_amount(money, amount):
	player.set_money(money)
	find_fish().set_amount(amount)

func buy(amount):

	if player.get_money() >= curr_price * amount:
		
		set_money_and_amount(player.get_money() - curr_price * amount, get_fish_amount() + amount)
		
		change_labels()

func sell(amount):
	
	if check_fish_amount(amount) == true:
		
		set_money_and_amount(player.get_money() + curr_price * amount, get_fish_amount() - amount)
		
		change_labels()
		

func _ready():	#prepare for graph
	randomize()
	$FishLine.width = 2		#size of the line
	$FishInformation.change_money(player.get_money())
	
