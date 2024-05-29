extends Node2D

@onready var collision_polygon_2d = $MapCollisions/StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $MapCollisions/StaticBody2D/CollisionPolygon2D/Polygon2D

var character_start_position = Vector2(288,328)

func _ready():
	paint()

func paint():
	polygon_2d.polygon = collision_polygon_2d.polygon
