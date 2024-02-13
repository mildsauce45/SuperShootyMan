extends CharacterBody2D
class_name Player

const SPEED = 4500.0
const JUMP_VELOCITY = -310.0

var dashCooldown: float = 0
var allowCoyoteTime: bool = false

#TODO: Dont like this on the player. Things like this should be in at responsible for determining an object's,
#or at least a complex entity like a player or enemy, speed
var direction: int = 1

const LEMON_SCENE = preload("res://Scenes/Weapons/lemon.tscn")

@onready var animatedSpriteController = $AnimatedSprite2D as PlayerAnimationController
@onready var shapeCast = $ShapeCast2D
@onready var speedChecker = $SpeedChecker as SpeedChecker
@onready var shootSpawn = $ShootSpawn
@onready var health = $Health as Health
@onready var dboost = $DBoost as DBoost

@export_group("Dashing")
@export var dashMultipler: float = 3.5
@export var dashLength: float = 0.2

@export_group("Jumping")
@export var coyoteTime: float = 0.15

func _process(_delta):
	_check_for_weapon_inputs()

func check_for_speeders():
	speedChecker.check_for_speeders(shapeCast)
	
func _check_for_weapon_inputs():
	if Input.is_action_just_pressed("shoot"):
		var lemon = LEMON_SCENE.instantiate()
		lemon.direction = animatedSpriteController.scale.x
		lemon.global_position = shootSpawn.global_position
		get_tree().root.add_child(lemon)
		animatedSpriteController.isShooting = true

func _on_area_entered(area):
	if area is Enemy:
		_contact_enemy(area as Enemy)
	elif area is DirectionChanger:
		direction = (area as DirectionChanger).get_direction(direction)
		dashCooldown = 0
			
func _contact_enemy(enemy: Enemy):
	if !dboost.is_active():
		health.takeDamage(enemy.contactDamage)
		print("hit enemy. remaining health: " + str(health.currentHealth))
		if health.is_dead():
			# TODO: we'll want to return to a checkpoint eventually
			get_tree().reload_current_scene()
		else:
			dashCooldown = 0
			dboost.start()
			velocity.y = dboost.baseVelocity.y
			velocity.x = dboost.baseVelocity.x * direction
			
