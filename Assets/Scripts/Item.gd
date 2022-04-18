extends Node


enum Rarity { Common, Uncommon, Rare, Mythical, Godly }

export var item_name: String
export var item_icon: StreamTexture
export var item_price: float
export var item_amount: int = 1
export(Rarity) var item_rarity


func _ready():
	
	name = item_name
	
