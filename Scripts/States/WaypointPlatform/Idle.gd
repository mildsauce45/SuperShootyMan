extends "res://Scripts/States/WaypointPlatform/WaypointPlatformState.gd"

func enter():
	if platform.trigger == WaypointPlatform.MOVE_TRIGGER.Always:
		Transition.emit(self, "moving")

func update(_delta: float):
	if is_player_on_platform() && platform.trigger == WaypointPlatform.MOVE_TRIGGER.PlayerStanding:
		Transition.emit(self, "moving")
