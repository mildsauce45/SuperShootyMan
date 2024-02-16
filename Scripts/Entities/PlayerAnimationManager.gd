extends AnimatedSprite2D

class_name PlayerAnimationController

var isDashing: bool = false
var isShooting: bool = false

var _shootAnimationHeldTime = 0

@onready var _shootSpawn = $"../ShootSpawn"

@export_group("Animation Timings")
@export var shootHoldTime: float = 0.75

@export_group("Repositiongs")
@export var jumpShootSpawn: Vector2 = Vector2(13, -5)
@export var normalShootSpawn: Vector2 = Vector2(13, -1)

func _process(delta):
	if _shootAnimationHeldTime > 0:
		_shootAnimationHeldTime -= delta
	
	if isShooting:
		_shootAnimationHeldTime = shootHoldTime
		isShooting = false

func PlayAnimation(velocity: Vector2):
	if not get_parent().is_on_floor():
		play("jump_shoot" if _shootAnimationHeldTime > 0 else "jump")
		_shootSpawn.position = jumpShootSpawn
		return
	
	_shootSpawn.position = normalShootSpawn
	if velocity.x == 0:
		play("idle")
		return
	
	play("run_shoot" if _shootAnimationHeldTime > 0 else "run")
