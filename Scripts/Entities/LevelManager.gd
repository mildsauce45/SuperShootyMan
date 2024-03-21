extends Node
class_name LevelManager

@export_group("Level Data Points")
@export var player: Player
@export var levelElements: Node
@export var hud: Hud
@export_group("")

var _last_checkpoint = Vector2.INF

var timeInLevel: float = 0

func _ready():
	player.Died.connect(_on_player_death)
	for child in levelElements.get_children():
		if child is Checkpoint:
			child.Entered.connect(_on_checkpoint_entered)
	
	hud.ready.connect(_on_hud_ready)
	
func _process(delta):
	timeInLevel += delta
	var msec = fmod(timeInLevel, 1) * 100
	var sec = fmod(timeInLevel, 60)
	var minutes = fmod(timeInLevel, 3600) / 60
	
	hud.set_time_label(("%02d:" % minutes) + ("%02d." % sec) + ("%02d" % msec))
	
func _on_player_death(_player):
	#TODO: Play a sound, maybe some particles as well
	get_tree().create_timer(1.5).timeout.connect(_return_to_last_checkpoint)

func _return_to_last_checkpoint():
	if (_last_checkpoint != Vector2.INF):
		player.position = _last_checkpoint
		get_tree().create_timer(0.2).timeout.connect(player.health.reset)
	else:
		print("no set checkpoint, resetting scene")
		get_tree().reload_current_scene()

func _on_checkpoint_entered(_checkpoint: Checkpoint, position: Vector2):
	if _last_checkpoint != position:
		_last_checkpoint = position
		# TODO: Might be nice to trigger the particle effects here

func _on_hud_ready():
	hud.initialize(player)
	hud.ready.disconnect(_on_hud_ready)
