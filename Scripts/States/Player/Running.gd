extends "res://Scripts/States/Player/PlayerState.gd"

var allowCoyoteTime = true

func enter():
	allowCoyoteTime = true #the only time coyote time should not be allowed is if the player actually jumped
	
func exit():
	player.allowCoyoteTime = allowCoyoteTime

func update(_delta: float):
	player.check_for_speeders()

func physics_update(delta: float):
	if player.health.is_dead():
		return
	
	if player.dboost.is_active() && player.dboost.override_velocity:
		_handle_dboost(delta)
	else:
		_handle_standard_inputs(delta)
		
	update_animation()
	player.move_and_slide()
	
	if not player.is_on_floor():
		Transition.emit(self, "airborne")

func _handle_dboost(delta: float):
	player.velocity.x = player.dboost.baseVelocity.x * delta
	
func _handle_standard_inputs(delta:float):
	var isDashing = get_is_dashing()
	
	if not isDashing:
		clear_dash_properties()
	
	if Input.is_action_just_pressed("dash"):
		set_dash_properties()
		isDashing = true

	if not isDashing and Input.is_action_just_pressed("jump"):
		player.velocity.y = player.JUMP_VELOCITY
		allowCoyoteTime = false
		
	player.velocity.x = player.speedChecker.get_speed(delta)
		
	reduce_dash_cooldown(isDashing, delta)
