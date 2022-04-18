extends Node2D

var toggled = false

func _input(event):
	if toggled == false:
		if Input.is_action_just_pressed("open_market"):
			print("bruh")
			toggled = true
			
			get_node("Fish Market Panel").visible = true
			get_node("Fish Market Panel").open_market()
	else:
		if Input.is_action_just_pressed("open_market"):
			
			toggled = false
			
			get_node("Fish Market Panel").visible = false
			get_node("Fish Market Panel").close_market()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

