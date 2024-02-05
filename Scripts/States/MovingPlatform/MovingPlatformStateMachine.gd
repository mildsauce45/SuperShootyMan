extends "res://Scripts/States/StateMachine.gd"
class_name MovingPlatformStateMachine

var platform: MovingPlatform

func _ready():
	platform = get_parent() as MovingPlatform
	if !platform:
		print("oh boy something bad happened")
		
	super._ready()
	
	for stateName in states:
		(states[stateName] as PlatformState).platform = platform
