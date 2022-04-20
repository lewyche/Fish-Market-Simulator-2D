extends StaticBody2D

onready var world = get_parent().get_parent()
onready var player = get_parent().get_node("Player")
onready var fish_data = world.get_node("Escape Menu").get_node("Fish Market Panel").get_node("FishData")



var common_fish = []
var uncommon_fish = []
var rare_fish = []

func separate_fish(fish, commons, uncommons, rares):
	for i in fish:
		if i.rarity == "common":
			commons.append(i)
		elif i.rarity == "uncommon":
			uncommons.append(i)
		elif i.rarity == "rare":
			rares.append(i)
	return [commons, uncommons, rares]


func _ready():
	var fish = fish_data.get_fishes()
	var types = separate_fish(fish, common_fish, uncommon_fish, rare_fish)
	common_fish = types[0]
	uncommon_fish = types[1]
	rare_fish = types[2]
	randomize()
	
func get_random(arr):
	if arr.size() == 1:
		return arr[0]
	var rand = randi() % arr.size()
	print(rand)
	return arr[rand]
	
func get_inventory():
	var player_children = player.get_children()
	var inventory : Array
	
	for child in player_children:
		
		if child.name == "Inventory":
			
			inventory = child.get_children()
			break
	
	return inventory
	
func add_fish(fish):
	for i in get_inventory():
		if fish.name == i.get_name():
			i.set_amount(i.get_amount() + 1)
			return i.name
	return "error"

func fish():
	var fished_fish = common_fish[1]

	var rand = randi() % 99

	if rand >= 0 and rand <= 49:
		fished_fish = get_random(common_fish)
	elif rand >= 50 and rand <= 79:
		fished_fish = get_random(uncommon_fish)
	elif rand >= 80 and rand <= 99:
		fished_fish = get_random(rare_fish)

	return add_fish(fished_fish)
