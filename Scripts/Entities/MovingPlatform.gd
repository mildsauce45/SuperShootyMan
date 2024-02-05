extends StaticBody2D

class_name MovingPlatform

enum MOVE_TRIGGER { Always, PlayerStanding }
enum EASING { None, InOut }

@onready var cast1 = $RayCast2D
@onready var cast2 = $RayCast2D2
@onready var cast3 = $RayCast2D3
@onready var cast4 = $RayCast2D4
@onready var cast5 = $RayCast2D5

@export_group("Movement Properties")
@export var trigger: MOVE_TRIGGER = MOVE_TRIGGER.PlayerStanding
@export var easing: EASING = EASING.None
@export var speed: float = 60
@export var target: Vector2
@export var reverseDelay: float = 0.75
