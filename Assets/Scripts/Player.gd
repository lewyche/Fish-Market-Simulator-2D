extends KinematicBody2D


var velocity = Vector2.ZERO
export var speed = 30000
export var direction : String
export var money = 0


onready var landing_rod = $FishingRod
var mouse_offset = Vector2(-1200,-750)

var menu_open = false

export var fishing = false


func get_money():
	return money

func set_money(val):
	money = val
	
	
	
func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("Punch") && fishing:
		
		landing_rod.position = get_global_mouse_position() + mouse_offset
		landing_rod.check_for_water()
	
	#Fishing 
	if Input.is_action_just_pressed("Fish"):
		
		if !fishing:
			
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
			
		if Input.get_action_strength("Down"):
			
			input.y = 1
			direction = "down"
			
		if Input.get_action_strength("Left"):
			
			input.y = 0
			input.x = -1
			direction = "left"
			
		if Input.get_action_strength("Right"):
			
			input.y = 0
			input.x = 1
			direction = "right"
			
		input = input.normalized()
		
		
		velocity = input * speed * delta
		velocity = move_and_slide(velocity)
		
		
		
		#PUNCH
		######################################

		if Input.is_action_just_pressed("Punch"):
			print(1)
		
		
