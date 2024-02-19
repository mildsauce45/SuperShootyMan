extends Area2D
class_name Checkpoint

signal Entered

func on_player_entered():
	#TODO: some sort of particle emission or lighting effect	
	Entered.emit(self, global_position)
