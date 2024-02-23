extends "res://Scripts/States/StateMachine.gd"

var platform: WaypointPlatform

func _ready():
	platform = get_parent() as WaypointPlatform
	if !platform:
		print("oh boy something bad happened")
		
	super._ready()
	
	for stateName in states:
		(states[stateName] as WaypointPlatformState).platform = platform
