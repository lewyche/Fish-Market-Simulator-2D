extends Node


enum Rarity { Common, Uncommon, Rare, Mythical, Godly }

export var item_name: String
export var item_icon: StreamTexture
export var item_price: float
export var item_amount: int = 1
export(Rarity) var item_rarity

func get_name():
	return item_name

func set_amount(amount):
	item_amount = amount

func get_amount():
	return item_amount

func _ready():
	
	name = item_name
	
