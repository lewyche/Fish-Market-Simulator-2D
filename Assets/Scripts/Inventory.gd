extends Control

var menu_items : Array
onready var player = get_node("/root/World/Player")



func delete_item(item):
	
	var inventory = find_inventory()
	
	for item_object in inventory:
		
		if item_object.item_name == item.item_name:
			
			print(item_object)
			item_object.queue_free()

	item.queue_free()
	refresh_inventory()


func find_inventory():
	
	#Find Inventory Items on Player Node
	#######################################
	var player_children = player.get_children()
	var inventory : Array
	
	for child in player_children:
		
		if child.name == "Inventory":
			
			inventory = child.get_children()
			break
	
	
	
	return inventory

func refresh_inventory():
	
	#Clear All Menu Items
	##############################
	for menu_item in menu_items:
		
		menu_item.queue_free()
	
	menu_items.clear()
	
	var inventory = find_inventory()
	
	#Sort Menu to represent inventory
	#####################################
	
	var item_position_x = 15
	var item_position_y = 150
	
	for item in inventory:
		
		var menu_item = $ItemMenuPrefab.duplicate()
		add_child(menu_item)
		
		menu_items.append(menu_item)
		
		#Position of item
		
		menu_item.rect_position.x = item_position_x
		menu_item.rect_position.y = item_position_y
		
		
		item_position_y += 150
		
		#Item values
		
		menu_item.item_name = item.item_name
		menu_item.hint_tooltip = item.item_description
		menu_item.item_icon = item.item_icon
		menu_item.item_price = item.item_price
		menu_item.item_amount = item.item_amount
		menu_item.item_rarity = item.item_rarity
		
		menu_item.update_menu()
		
