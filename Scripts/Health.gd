extends Node
class_name Health

signal HealthChanged

@export var maxHealth: int

var currentHealth = 1

func _ready():
	reset()

func heal(amount: int):
	currentHealth += amount
	_raise_health_changed()
	if currentHealth > maxHealth:
		currentHealth = maxHealth

func takeDamage(amount: int):
	currentHealth -= amount
	_raise_health_changed()
	if currentHealth <= 0:
		# TODO: We'll want something a little more impressive but for now just remove the thing
		get_parent().queue_free()
		
func is_dead():
	return currentHealth <= 0
	
func die():
	currentHealth = 0
	
func reset():
	currentHealth = maxHealth
	_raise_health_changed()
	
func _raise_health_changed():
	HealthChanged.emit(currentHealth)	
