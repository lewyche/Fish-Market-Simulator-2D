extends Area2D


func check_for_water():
	
	print(1)
	var collisions = get_overlapping_bodies()
	var water_body : StaticBody2D
	
	for collision in collisions:
		
		if collision.is_in_group("Water"):
			
			water_body = collision
			break
			
	if water_body != null:
		
		water_body.fish()
