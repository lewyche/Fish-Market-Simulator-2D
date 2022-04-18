extends Control

var menu_open = false

func _ready():
	
	visible = false
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(_event):
	
	print(1)
	
	
	if Input.is_action_just_pressed("Escape"):
		
		$Inventory.refresh_inventory()
		
		if menu_open == false:
			
			menu_open = true
			
			visible = true
			get_tree().paused = true
			
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		else:
			
			menu_open = false
			
			visible = false
			
			get_tree().paused = false
			
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
