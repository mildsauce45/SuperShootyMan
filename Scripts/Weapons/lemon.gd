extends Area2D
class_name Lemon

var direction: int = 1

@export_group("Speed Properties")
@export var horizontalSpeed: float = 300

@export_group("Weapon Properties")
@export var damage: int = 1

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += delta * horizontalSpeed * direction	

func _on_visible_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Enemy:
		(area as Enemy).health.takeDamage(damage)
		# TODO: play sound effect
		queue_free()
