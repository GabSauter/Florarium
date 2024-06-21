extends Node2D

@onready var running_scene = $RunningScene

func next_scene(new_game_scene):
	var tree = get_tree()
	var current_scene = running_scene.get_child(0)
	if current_scene:
		current_scene.queue_free()

	var new_scene_instance = new_game_scene.instantiate()
	running_scene.add_child(new_scene_instance)
