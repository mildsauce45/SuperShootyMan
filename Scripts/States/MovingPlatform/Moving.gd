extends "res://Scripts/States/MovingPlatform/PlatformState.gd"

var UNASSIGNED = Vector2(42.42, 42.42)

var initialPosition: Vector2 = UNASSIGNED
var currentTarget: Vector2 = UNASSIGNED

# TODO: id prefer to do this in an _ready or onready
func enter():
	if initialPosition == UNASSIGNED:
		initialPosition = platform.global_position
		
	if currentTarget == UNASSIGNED:
		currentTarget = platform.target

func update(delta: float):
	if !handlePlayerCollisions() && platform.trigger == MovingPlatform.MOVE_TRIGGER.PlayerStanding:
		Transition.emit(self, "idle");
		return
	
	platform.global_position = platform.global_position.move_toward(currentTarget, delta * platform.speed)
	
	if platform.global_position.distance_to(currentTarget) < 0.25:
		platform.global_position = currentTarget
		currentTarget = initialPosition if platform.global_position == platform.target else platform.target
		Transition.emit(self, "wait")
