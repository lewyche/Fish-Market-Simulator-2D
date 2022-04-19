extends StaticBody2D


onready var world = get_parent().get_parent()
onready var player = world.get_node("WorldCanvas").get_node("Player")
onready var inventory = world.get_node("Escape Menu").get_node("Escape").get_node("Inventory")
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
	
	for i in range(30):
		print(fish())
	
	
func get_random(arr):
	var rand = randi() % arr.size()
	return arr[rand]

func fish():
	var rand = randi() % 99
	if rand >= 0 and rand <= 49:
		return get_random(common_fish).name
	elif rand >= 50 and rand <= 79:
		return get_random(uncommon_fish).name
	elif rand >= 80 and rand <= 99:
		return get_random(rare_fish).name
