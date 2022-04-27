extends Camera2D


func _process(delta):
	
	position.x = get_parent().position.x
	position.y = get_parent().position.y
	
