extends "res://Scripts/States/Player/PlayerState.gd"

var deathYValue = 80
var allowCoyoteTime = true
var _coyoteTimeTimer: float

func enter():
	allowCoyoteTime = player.allowCoyoteTime
	_coyoteTimeTimer = player.coyoteTime

func physics_update(delta: float):
	if player.health.is_dead():
		return
	
	if player.dboost.is_active() && player.dboost.override_velocity:
		_handle_dboost(delta)
	else:
		_handle_standard_inputs(delta)
	
	update_animation()
	player.move_and_slide()
	if _coyoteTimeTimer > 0:
		_coyoteTimeTimer -= delta
	
	if player.position.y > deathYValue:
		player.health.die()
		player.player_died()
	elif player.is_on_floor():
		Transition.emit(self, "running")
		player.dboost.override_velocity = false
		
func _handle_dboost(delta: float):
	player.velocity.x = player.dboost.baseVelocity.x * delta
	player.velocity.y += gravity * delta
	
func _handle_standard_inputs(delta: float):
	var isDashing = get_is_dashing()
	
	# add gravity
	if not isDashing:
		player.velocity.y += gravity * delta
		clear_dash_properties()
	
	if Input.is_action_just_pressed("dash") and not isDashing:
		set_dash_properties()
		isDashing = true
		
	if not isDashing and Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.5
	elif not isDashing and Input.is_action_just_pressed("jump") and _can_coyote_jump():
		player.velocity.y = player.speedChecker.STANDARD_JUMP_VELOCITY
		allowCoyoteTime = false
		
	player.velocity.x = player.speedChecker.get_speed(delta)
	
	reduce_dash_cooldown(isDashing, delta)
	
func _can_coyote_jump():
	return allowCoyoteTime && _coyoteTimeTimer > 0
