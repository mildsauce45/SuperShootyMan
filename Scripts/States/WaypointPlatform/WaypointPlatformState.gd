extends "res://Scripts/States/State.gd"
class_name WaypointPlatformState

var platform: WaypointPlatform
var _lastIsColliding = false

func is_player_on_platform():
	var isColliding = platform._is_player_on_platform
	
	if isColliding and not _lastIsColliding:
		_get_player().reparent(platform)
	elif not isColliding and _lastIsColliding:
		_get_player().reparent(get_tree().root)
		
	_lastIsColliding = isColliding
	
	return isColliding

func _get_player():
	var player = get_tree().get_first_node_in_group("Player")
	return player;
