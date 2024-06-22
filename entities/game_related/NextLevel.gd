extends Area2D

@export var new_scene: PackedScene

var levelContainer: LevelContainer

func _ready():
	levelContainer = get_tree().current_scene.get_node("LevelContainer")

func _on_body_entered(body: Node):
	if body is Player:
		levelContainer.next_level(new_scene)
