class_name Inventory

signal Swapped
signal Fired

var _weapon_index: int = 0

var _all_weapons = [
	InGameWeapon.new(preload("res://Resources/Weapons/Buster.tres"))
]

func current_weapon():
	return _all_weapons[_weapon_index]
	
func swap_right():
	print("swapping right")
	_weapon_index += 1
	if _weapon_index >= _all_weapons.size():
		_weapon_index = 0
	Swapped.emit()

func swap_left():
	print("swapping left")
	_weapon_index -= 1
	if _weapon_index < 0:
		_weapon_index = _all_weapons.size() - 1
	Swapped.emit()
	
func fired():
	Fired.emit(current_weapon().current_energy)
