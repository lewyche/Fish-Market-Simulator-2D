extends MenuButton


enum Rarity { Common, Uncommon, Rare, Mythical, Godly }

export var item_name: String
export var item_icon: StreamTexture
export var item_price: float
export var item_amount: int = 1
export(Rarity) var item_rarity

func _init():
	
	update_menu()
	
	var popup = get_popup()
		
	popup.add_item("Delete")
	
	popup.connect("id_pressed", self, "item_pressed")
	

func item_pressed(id):
	
	var menu_item_name = get_popup().get_item_text(id)
	
	if menu_item_name == "Delete":
		
		get_parent().delete_item(self)

func update_menu():
	
	text = str(item_name) + ", Rarity: " + str(item_rarity) + ", Value: " + str(item_price) + ", Amount: " + str(item_amount)
	
	icon = item_icon
