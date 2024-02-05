extends Camera2D

@export_group("Camera Sync")
@export var syncNode: Node2D
@export var shouldCameraSync: bool
@export var maxCameraY: float = -40
@export_group("")

func _process(_delta):
	if !syncNode:
		return
		
	if shouldCameraSync:
		global_position.x = syncNode.global_position.x
		
		global_position.y = syncNode.global_position.y
		if global_position.y > maxCameraY:
			global_position.y = maxCameraY
