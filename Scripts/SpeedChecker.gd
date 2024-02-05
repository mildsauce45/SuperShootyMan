extends Node
class_name SpeedChecker

const STANDARD_RUN_SPEED = 4500.0

var speederMultiplier: float = 1

var _speed_modifiers = { }

func get_speed(dashMultiplier):
	var val = STANDARD_RUN_SPEED
	#player.velocity.x = player.SPEED * delta * player.speedChecker.speederMultiplier * (player.dashMultipler if isDashing else 1.0)

func check_for_speeders(shapeCast: ShapeCast2D):
	speederMultiplier = 1
	if shapeCast.is_colliding():
		var collider = shapeCast.get_collider(0)
		if collider.is_in_group("Speeders"):			
			var multiplerNode = (collider as Node).find_child("SpeedModifier") as SpeedModifier
			speederMultiplier = multiplerNode.multiplier
