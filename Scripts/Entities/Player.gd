extends CharacterBody2D
class_name Player

const SPEED = 4500.0
const JUMP_VELOCITY = -310.0

const LEFT = Vector2(-1, 1)
const RIGHT = Vector2.ONE

var dashCooldown: float = 0
var allowCoyoteTime: bool = false

#TODO: Dont like this on the player. Things like this should be in at responsible for determining an object's,
#or at least a complex entity like a player or enemy, speed
var direction: int = 1

var equipped_weapon: Weapon = preload("res://Resources/Weapons/Buster.tres")

@onready var animatedSpriteController = $AnimatedSprite2D as PlayerAnimationController
@onready var shapeCast = $ShapeCast2D
@onready var speedChecker = $SpeedChecker as SpeedChecker
@onready var shootSpawn = %ShootSpawn
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
		var projectile = _spawn_weapon_projectile()
		get_tree().root.add_child(projectile)
		animatedSpriteController.isShooting = true

func _on_area_entered(area):
	if area is Enemy:
		_contact_enemy(area as Enemy)
	elif area is DirectionChanger:
		_direction_switch(area as DirectionChanger)
			
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
		
func _spawn_weapon_projectile():
	var projectile = equipped_weapon.projectile.instantiate()
	projectile.direction = direction
	projectile.global_position = shootSpawn.global_position
	return projectile

func _direction_switch(changer: DirectionChanger):
	dashCooldown = 0
	var newDirection = changer.get_direction(direction)
	if newDirection != direction:
		# this is super weird but i found the solution here:
		# https://forum.godotengine.org/t/why-my-character-scale-keep-changing/13909/4
		if newDirection < 0:
			scale.y = -1
			rotation_degrees = 180
		else:
			scale.y = 1
			rotation_degrees = 0
	direction = newDirection
