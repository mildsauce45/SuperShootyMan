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
		var target = Vector2(syncNode.global_position)
		
		global_position = global_position.lerp(target, 0.2)
		if global_position.y > maxCameraY:
			global_position.y = maxCameraY
