extends Node
class_name DBoost

@export_group("Dboost")
@export var duration: float = 1
@export var baseVelocity: Vector2 = Vector2.ZERO

var override_velocity: bool = false

var _remaining: float = 0

func is_active():
	return _remaining > 0
	
func start():
	_remaining = duration
	override_velocity = true

func _process(delta):
	if is_active():
		_remaining -= delta
		if (_remaining < 0):
			_remaining = 0
			override_velocity = false
