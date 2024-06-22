class_name UIContainer extends CanvasLayer

func next_ui(next_ui_scene):
	if self.get_child_count() > 0:
		var current_scene = self.get_child(0)
		current_scene.queue_free()

	var new_scene_instance = next_ui_scene.instantiate()
	self.add_child(new_scene_instance)
