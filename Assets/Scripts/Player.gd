extends KinematicBody2D


var velocity = Vector2.ZERO
export var speed = 50000
export var direction : String
export var money = 0


onready var landing_rod = $FishingRod
var mouse_offset = Vector2(0,0)

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
	
	
	if Input.is_action_just_pressed("Punch") && fishing:
		
		landing_rod.position = get_local_mouse_position() + mouse_offset
		landing_rod.check_for_water()
	
	#Fishing 
	if Input.is_action_just_pressed("Fish"):
		
		if !fishing:
			
			animation_player.play("Fishing")
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
			direction = "up"
			$Sprite.rotation_degrees = 0
			$Sprite.flip_v = false
			
		if Input.get_action_strength("Down"):
			
			input.y = 1
			direction = "down"
			$Sprite.rotation_degrees = 0
			$Sprite.flip_v = true
			
		if Input.get_action_strength("Left"):
			
			input.y = 0
			input.x = -1
			direction = "left"
			$Sprite.rotation_degrees = -90
			$Sprite.flip_v = false
			
		if Input.get_action_strength("Right"):
			
			input.y = 0
			input.x = 1
			direction = "right"
			$Sprite.rotation_degrees = 90
			$Sprite.flip_v = false
			
		input = input.normalized()
		
		
		velocity = input * speed * delta
		velocity = move_and_slide(velocity)
		
		if velocity != Vector2.ZERO:
			
			animation_player.play("Walk")
		else:
			animation_player.play("Idle")
		
		#PUNCH
		######################################

		if Input.is_action_just_pressed("Punch"):
			
			animation_player.play("Punch")
		
		
