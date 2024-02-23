extends Area2D
class_name SpeedCollider

signal _speed_collider_entered
signal _speed_collider_exited

@onready var modifier = %SpeedModifier as SpeedModifier

func on_collision_enter(player: Player):
	var parent = get_parent()
	player.speedChecker.add_modifier(_get_modifier_name(parent), modifier.multiplier)
	_speed_collider_entered.emit(self)
	
func on_collision_exit(player: Player):
	var parent = get_parent()
	player.speedChecker.remove_modifier(_get_modifier_name(parent))
	_speed_collider_exited.emit(self)
	
func _get_modifier_name(parent: Node):
	if "modifier_name" in parent:
		return parent.modifier_name
	
	return "random_collider"
