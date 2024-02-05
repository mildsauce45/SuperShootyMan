extends "res://Scripts/States/State.gd"
class_name PlayerState

var player: Player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_is_dashing():
	return player.dashCooldown > 0
	
func set_dash_properties():
	player.dashCooldown = player.dashLength
	player.velocity.y = 0
	
func reduce_dash_cooldown(isDashing: bool, delta: float):
	if isDashing:
		player.dashCooldown -= delta
		if player.dashCooldown < 0:
			player.dashCooldown = 0

# TODO: i dont like this, i think the enter and/or exit functions should set animations directly, but the blended shoot animations complicate that
func update_animation():
	player.animatedSpriteController.PlayAnimation(player.velocity, player.direction)
