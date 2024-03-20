extends CharacterBody2D
class_name Player

signal Died

var dashCooldown: float = 0
var allowCoyoteTime: bool = false

var inventory: Inventory = Inventory.new()

@onready var animatedSpriteController = $AnimatedSprite2D as PlayerAnimationController
@onready var speedChecker = $SpeedChecker as SpeedChecker
@onready var shootSpawn = %ShootSpawn
@onready var health = $Health as Health
@onready var dboost = $DBoost as DBoost

@export_group("Dashing")
@export var dashMultiplier: float = 3.5
@export var dashLength: float = 0.2

@export_group("Jumping")
@export var coyoteTime: float = 0.15

func _process(_delta):
	_check_for_weapon_inputs()

func player_died():
	Died.emit(self)

func _check_for_weapon_inputs():
	if Input.is_action_just_pressed("shoot") and inventory.current_weapon().can_fire():
		var projectile = _spawn_weapon_projectile()
		get_tree().root.add_child(projectile)
		animatedSpriteController.isShooting = true
		inventory.current_weapon().fired()
		inventory.fired()
	elif Input.is_action_just_released("shift_weapon_left"):
		inventory.swap_left()
	elif Input.is_action_just_released("shift_weapon_right"):
		inventory.swap_right()

func _on_area_entered(area):
	#TODO: this is becoming untenable, come up with something better
	if area is Enemy:
		_contact_enemy(area as Enemy)
	elif area is DirectionChanger:
		_direction_switch(area as DirectionChanger)
	elif area is Checkpoint:
		(area as Checkpoint).on_player_entered()
	elif area is SpeedCollider:
		(area as SpeedCollider).on_collision_enter(self)

func _on_area_exited(area):
	if area is SpeedCollider:
		(area as SpeedCollider).on_collision_exit(self)

func _contact_enemy(enemy: Enemy):
	if !dboost.is_active():
		health.takeDamage(enemy.contactDamage)
		print("hit enemy. remaining health: " + str(health.currentHealth))
		if health.is_dead():
			player_died()
		else:
			dashCooldown = 0
			dboost.start()
			velocity.y = dboost.baseVelocity.y
			velocity.x = dboost.baseVelocity.x * speedChecker.direction
		
func _spawn_weapon_projectile():
	var projectile = inventory.current_weapon().weaponResource.projectile.instantiate()
	projectile.direction = speedChecker.direction
	projectile.global_position = shootSpawn.global_position
	return projectile

func _direction_switch(changer: DirectionChanger):
	dashCooldown = 0
	
	# these are super weird but i found the solution here:
	# https://forum.godotengine.org/t/why-my-character-scale-keep-changing/13909/4
	var flip_left = func():
		scale.y = -1
		rotation_degrees = 180
	var flip_right = func():
		scale.y = 1
		rotation_degrees = 0
	
	speedChecker.change_direction(changer, flip_left, flip_right)
