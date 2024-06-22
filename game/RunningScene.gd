class_name RunningScene extends Node2D

func next_scene(new_game_scene):
	var tree = get_tree()
	var current_scene = self.get_child(0)
	if current_scene:
		current_scene.queue_free()

	var new_scene_instance = new_game_scene.instantiate()
	self.add_child(new_scene_instance)
