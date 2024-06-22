class_name LevelContainer extends Node2D

func next_level(next_level_scene):
	if self.get_child_count() > 0:
		var current_scene = self.get_child(0)
		current_scene.queue_free()
	
	var new_scene_instance = next_level_scene.instantiate()
	self.add_child(new_scene_instance)
