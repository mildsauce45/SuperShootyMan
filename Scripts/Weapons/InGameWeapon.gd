class_name InGameWeapon

const MAX_ENERGY: int = 30

var weaponResource: Weapon
var current_energy: int

func _init(weapon: Weapon):
	weaponResource = weapon
	current_energy = MAX_ENERGY
	
func can_fire():
	return current_energy > 0
	
func fired():
	current_energy -= weaponResource.energyConsumption
	if current_energy < 0:
		current_energy = 0
