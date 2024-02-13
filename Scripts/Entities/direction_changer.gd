extends Area2D
class_name DirectionChanger

enum ChangeDirection { INVERT, FORCE_LEFT, FORCE_RIGHT }

func get_direction(curr_direction: int):
	var direction = ($".." as DirectionChangerRoot).direction
	
	if direction == ChangeDirection.FORCE_LEFT:
		return -1
	elif direction == ChangeDirection.FORCE_LEFT:
		return 1
	else:
		return curr_direction * -1 
