extends Control
class_name Hud

@onready var weaponIcon = %WeaponIcon as TextureRect
@onready var weaponEnergy = %WeaponEnergy as ProgressBar

func initialize(inventory: Inventory):
	inventory.Swapped.connect(_on_weapon_swap)
	inventory.Fired.connect(_on_weapon_fired)
	_on_weapon_swap(inventory.current_weapon())

func _on_weapon_swap(weapon: InGameWeapon):
	weaponIcon.texture = weapon.weaponResource.uiIcon
	weaponEnergy.value = weapon.current_energy
	
func _on_weapon_fired(currentEnergy: int):
	weaponEnergy.value = currentEnergy
