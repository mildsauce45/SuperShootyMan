extends "res://Scripts/States/StateMachine.gd"
class_name PlayerStateMachine

var player: Player

func _ready():
	player = get_parent() as Player
	if !player:
		print("oh boy something bad happened")
		
	super._ready()
	
	for stateName in states:
		(states[stateName] as PlayerState).player = player
