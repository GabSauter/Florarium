extends Area2D

@export var new_scene: PackedScene

func _on_body_entered(body: Node):
	if body is Player:
		call_deferred("_change_scene")

func _change_scene():
	var tree = get_tree()
	var current_scene = tree.current_scene
	current_scene.queue_free()
	
	var new_scene_instance = new_scene.instantiate()
	tree.root.add_child(new_scene_instance)
	tree.current_scene = new_scene_instance
