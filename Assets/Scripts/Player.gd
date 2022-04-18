extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 30000


var menu_open = false

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	#INPUT
	#########################################
	var direction = Vector2.ZERO
	direction.y = -Input.get_action_strength("Up") + Input.get_action_strength("Down")
	direction.x = -Input.get_action_strength("Left") + Input.get_action_strength("Right")
	
	direction = direction.normalized()
	
	velocity = direction * speed * delta
	velocity = move_and_slide(velocity)
	
	
	
	#PUNCH
	######################################

	if Input.is_action_just_pressed("Punch"):
		print(1)
	
