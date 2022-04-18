extends KinematicBody

var velocity = Vector3.ZERO
export var speed = 3500
export var gravity = -136
export var jump_force = 45
var grounded = true


var cam_rot = Vector3.ZERO

export var mouse_sensitivity = 0.2


onready var ground_raycast : RayCast = $RayCast
onready var camera_pivot : Spatial = $Camera_Pivot


onready var anim_tree = $AnimationTree


var menu_open = false

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	#INPUT
	#########################################
	var direction = Vector3.ZERO
	direction.x = Input.get_action_strength("Forward") - Input.get_action_strength("Back")
	direction.z = -Input.get_action_strength("Left") + Input.get_action_strength("Right")
	
	direction = direction.normalized()
	
	
	#GRAVITY AND JUMP
	#########################################
	grounded = true if ground_raycast.is_colliding() else false
	
	if Input.is_action_just_pressed("Jump") && grounded:
		
		velocity.y = jump_force
		
		anim_tree.set("parameters/JumpShot/active", true)
	
	velocity.y += gravity * delta
	
	
	
	#FINAL VELOCITY
	#########################################
	velocity = $Armature.transform.basis * direction * speed * delta + Vector3(0,velocity.y,0)
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
	#ROTATE CAMERA
	#########################################
	camera_pivot.rotation_degrees.z = clamp(cam_rot.x, -60, 25)
	camera_pivot.rotation_degrees.y = cam_rot.y
	
	
	
	#ROTATE PLAYER TO CAMERA
	#######################################
	
	if Vector3(velocity.x,0,velocity.z) != Vector3.ZERO:
		
		$Armature.rotation_degrees.y = cam_rot.y
	
	
	#PUNCH
	######################################

	if Input.is_action_just_pressed("Punch") && grounded:
		
		anim_tree.set("parameters/PunchShot/active", true)
	


	#ANIMATIONS
	#######################################
	
	
	
	anim_tree.set("parameters/Idle-Run/blend_position", velocity.length())
	

func _input(event):
	
	if event is InputEventMouseMotion && Input.MOUSE_MODE_CAPTURED:
		
		cam_rot.x += -event.relative.y*mouse_sensitivity
		cam_rot.y += -event.relative.x*mouse_sensitivity
