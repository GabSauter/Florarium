extends Node2D

@export var new_scene: PackedScene

var level_container: LevelContainer

func _ready():
	level_container = get_tree().current_scene.get_node("LevelContainer")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		level_container.next_level(new_scene)
