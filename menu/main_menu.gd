class_name MainMenu
extends Control

@onready var new_game_button = $MarginContainer/VBoxContainer/VBoxContainer2/NewGameButton
@onready var quit_button = $MarginContainer/VBoxContainer/VBoxContainer2/QuitButton

@export var new_game_scene: PackedScene

func _on_start_button_button_down():
	var tree = get_tree()
	var current_scene = tree.current_scene
	current_scene.queue_free()
	
	var new_scene_instance = new_game_scene.instantiate()
	tree.root.add_child(new_scene_instance)
	tree.current_scene = new_scene_instance

func _on_quit_button_button_down():
	get_tree().quit()
