extends Node
class_name Health

@export var maxHealth: int

var currentHealth = 1

func _ready():
	currentHealth = maxHealth

func heal(amount: int):
	currentHealth += amount

func takeDamage(amount: int):
	currentHealth -= amount
	if currentHealth <= 0:
		# TODO: We'll want something a little more impressive but for now just remove the thing
		get_parent().queue_free()
		
func is_dead():
	return currentHealth <= 0
	
func die():
	currentHealth = 0
