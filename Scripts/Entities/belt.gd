extends StaticBody2D
class_name Belt

const PIXEL_SIZE: int = 16

@onready var beltSprite := $Belt as Sprite2D
@onready var beltExit := $BeltExit as Sprite2D
@onready var collisionShape := $CollisionShape2D as CollisionShape2D
@onready var speedModifier := $SpeedModifier as SpeedModifier

@export_group("Belt Properties")
@export var beltLength: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var regionRect = Rect2(beltSprite.region_rect)
	regionRect.size = Vector2(PIXEL_SIZE * beltLength, PIXEL_SIZE)
	beltSprite.region_rect = regionRect
	beltSprite.position = Vector2(PIXEL_SIZE * beltLength / 2.0 - PIXEL_SIZE / 2.0, 0)
	
	var shape = RectangleShape2D.new()
	shape.size = Vector2(PIXEL_SIZE * 2 + PIXEL_SIZE * beltLength, PIXEL_SIZE)	
	collisionShape.shape = shape
	collisionShape.position = Vector2(PIXEL_SIZE * beltLength / 2.0, 0)
	
	beltExit.offset = Vector2(PIXEL_SIZE * beltLength + PIXEL_SIZE, 0)
