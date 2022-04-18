extends Node

func _add_item(item):
	
	var inventory = get_children()
	
	var item_exists = false
	
	for item in inventory:
		
		for comparission_item in inventory:
			
			if item.item_name == comparission_item:
				
				comparission_item.item_amount += 1
				item_exists = true
	
	if !item_exists:
		
		add_child(item)
