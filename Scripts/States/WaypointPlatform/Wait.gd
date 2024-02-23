extends "res://Scripts/States/WaypointPlatform/WaypointPlatformState.gd"

var waitedFor: float

func enter():
	waitedFor = 0

func update(delta: float):
	waitedFor += delta
	if waitedFor >= platform.reverseDelay:
		Transition.emit(self, "moving")
