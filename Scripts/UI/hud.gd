extends Control
class_name Hud

@onready var weaponIcon = %WeaponIcon as TextureRect
@onready var weaponEnergy = %WeaponEnergy as ProgressBar
@onready var playerHealth = %PlayerHealthBar as ProgressBar
@onready var timeControl = %TimeIndicator as Label

func initialize(player: Player):
	player.health.HealthChanged.connect(_on_player_health_changed)
	_on_player_health_changed(player.health.currentHealth)
	
	player.inventory.Swapped.connect(_on_weapon_swap)
	player.inventory.Fired.connect(_on_weapon_fired)
	_on_weapon_swap(player.inventory.current_weapon())
	
func set_time_label(timeString):
	timeControl.text = timeString

func _on_weapon_swap(weapon: InGameWeapon):
	weaponIcon.texture = weapon.weaponResource.uiIcon
	weaponEnergy.value = weapon.current_energy
	
func _on_weapon_fired(currentEnergy: int):
	weaponEnergy.value = currentEnergy

func _on_player_health_changed(currentHealth: int):
	playerHealth.value = currentHealth
