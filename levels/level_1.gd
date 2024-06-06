extends Node2D

@onready var collision_polygon_2d = $MapCollisions/StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $MapCollisions/StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var player: Player = $"0/Player"

var character_start_position = Vector2(10699,-770)

func _ready():
	paint()
	player.respawn_position = character_start_position

func paint():
	polygon_2d.polygon = collision_polygon_2d.polygon
