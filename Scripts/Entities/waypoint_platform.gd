extends Node2D
class_name WaypointPlatform

enum MOVE_TRIGGER { Always, PlayerStanding }
enum EASING { None, InOut }

var _is_player_on_platform: bool = false

@export_group("Movement Properties")
@export var trigger: MOVE_TRIGGER = MOVE_TRIGGER.PlayerStanding
@export var easing: EASING = EASING.None
@export var speed: float = 60
@export var target: Vector2
@export var reverseDelay: float = 0.75
@export var modifier_name = "ground_modifier"

func _on_speed_collider_entered(_collider):
	_is_player_on_platform = true

func _on_speed_collider_exited(_collider):
	_is_player_on_platform = false
