extends "res://Scripts/States/State.gd"
class_name PlatformState

var platform: MovingPlatform
var lastIsColliding = false

func handlePlayerCollisions():
	var isColliding = _is_any_cast_colliding()
	
	if isColliding and not lastIsColliding:
		_get_player().reparent(platform)
	elif not isColliding and lastIsColliding:
		_get_player().reparent(get_tree().root)
		
	lastIsColliding = isColliding
	
	return isColliding
	
func _is_any_cast_colliding():
	return platform.cast1.is_colliding() || platform.cast2.is_colliding() || platform.cast3.is_colliding() || platform.cast4.is_colliding() || platform.cast5.is_colliding()

func _get_player():
	var player = get_tree().get_first_node_in_group("Player")
	return player;
