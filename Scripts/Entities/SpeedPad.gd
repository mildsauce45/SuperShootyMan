extends Node2D
class_name SpeedPad

const PIXEL_SIZE: int = 16

@onready var beltSprite := %BeltSprite as Sprite2D
@onready var beltExit := %BeltExit as Sprite2D
@onready var beltCollisionShape := %BeltCollider as CollisionShape2D
@onready var speedCollisionShape := %SpeedCollisionShape as CollisionShape2D

@export_group("Belt Properties")
@export var beltLength: int = 1
@export var modifier_name = "speed_pad"

func _ready():
	var regionRect = Rect2(beltSprite.region_rect)
	regionRect.size = Vector2(PIXEL_SIZE * beltLength, PIXEL_SIZE)
	beltSprite.region_rect = regionRect
	beltSprite.position = Vector2(PIXEL_SIZE * beltLength / 2.0 - PIXEL_SIZE / 2.0, 0)
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(PIXEL_SIZE * 2 + PIXEL_SIZE * beltLength, PIXEL_SIZE)
	beltCollisionShape.shape = shape
	beltCollisionShape.position = Vector2(PIXEL_SIZE * beltLength / 2.0, 0)
	
	speedCollisionShape.shape = shape
	speedCollisionShape.position = Vector2(PIXEL_SIZE * beltLength / 2.0, -2)
	
	beltExit.offset = Vector2(PIXEL_SIZE * beltLength + PIXEL_SIZE, 0)
