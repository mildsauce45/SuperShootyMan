extends "res://Scripts/States/MovingPlatform/PlatformState.gd"

func enter():
	if platform.trigger == MovingPlatform.MOVE_TRIGGER.Always:
		Transition.emit(self, "moving")

func update(_delta: float):
	if handlePlayerCollisions() && platform.trigger == MovingPlatform.MOVE_TRIGGER.PlayerStanding:
		Transition.emit(self, "moving")
