extends KinematicBody2D


var velocity = Vector2.ZERO
export var speed = 50000
export var direction : String = "Up"
export var money = 0


onready var landing_rod = $FishingRod

var menu_open = false

export var fishing = false

onready var animation_player = $AnimationPlayer

func get_money():
	return money

func set_money(val):
	money = val
	
	
	
func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	if !GlobalVariables.gaming:
		if Input.is_action_just_pressed("Punch") && fishing:
			
			landing_rod.position = get_local_mouse_position()
			landing_rod.check_for_water()
	
	#Fishing 
	if Input.is_action_just_pressed("Fish"):
		
		if !fishing:
			
			animation_player.play(direction + "_Fish")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			fishing = true
		
			$FishingRod/Sprite.visible = true
			
		
		else:
			
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			fishing = false
			$FishingRod/Sprite.visible = false
			
	
	
	if(!fishing):
		
	
		#INPUT
		#########################################
		
		var input = Vector2.ZERO
		
		if Input.get_action_strength("Up"):
			
			input.y = -1
			direction = "Up"
			
		if Input.get_action_strength("Down"):
			
			input.y = 1
			direction = "Down"
			
		if Input.get_action_strength("Left"):
			
			input.y = 0
			input.x = -1
			direction = "Left"
			
		if Input.get_action_strength("Right"):
			
			input.y = 0
			input.x = 1
			direction = "Right"
			
		input = input.normalized()
		
		
		velocity = input * speed * delta
		velocity = move_and_slide(velocity)
		
		if velocity != Vector2.ZERO:
			
			animation_player.play(direction + "_Run")
		else:
			animation_player.play(direction + "_Idle")
		
		#PUNCH
		######################################

		if Input.is_action_just_pressed("Punch"):
			
			animation_player.play(direction + "_Punch")
		
		
