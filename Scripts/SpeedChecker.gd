extends Node
class_name SpeedChecker

const STANDARD_RUN_SPEED = 4500.0
const STANDARD_JUMP_VELOCITY = -310.0

var _speed_modifiers = { }
var direction: int = 1

func add_modifier(key: String, amount: float):
	_speed_modifiers[key] = amount
	
func remove_modifier(key: String):
	if _speed_modifiers.has(key):
		_speed_modifiers.erase(key)

func get_speed(delta: float):
	var val = STANDARD_RUN_SPEED
	
	var speederMultiplier = 1
	for key in _speed_modifiers:
		speederMultiplier *= _speed_modifiers[key]

	return val * delta * speederMultiplier * direction

func change_direction(changer: DirectionChanger, change_to_left: Callable, change_to_right: Callable):
	var newDirection = changer.get_direction(direction)
	if newDirection != direction:
		if newDirection < 0:
			change_to_left.call()
		else:
			change_to_right.call()
	direction = newDirection
