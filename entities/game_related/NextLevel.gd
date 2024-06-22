extends Area2D

@export var new_scene: PackedScene

var runningScene: RunningScene

func _ready():
	runningScene = get_tree().current_scene.get_node("RunningScene")

func _on_body_entered(body: Node):
	if body is Player:
		runningScene.next_scene(new_scene)
