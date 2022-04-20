extends Node

onready var ui = get_node("/root/World/Escape Menu/Label")
var pond : StaticBody2D
var fishing_time_window = 0.5

func play_animation():	#plays fish bite animation
	ui.visible = true
	GlobalVariables.gaming = true

func fishing_game(water_body):

	pond = water_body
	var wait_time = randi() % 10
	yield(get_tree().create_timer(wait_time), "timeout")
	ui.text = "LEFT CLICK NOW!!!!"
	play_animation()
	yield(get_tree().create_timer(fishing_time_window), "timeout")
	GlobalVariables.gaming = false

func _input(event):
	if GlobalVariables.gaming == true:
		if Input.is_action_just_pressed("Punch"):
			ui.text = "YOU GOT " + 	pond.fish()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
