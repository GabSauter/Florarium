extends Node2D

@export var pause_menu: PackedScene = preload("res://ui/menu/pause_menu/pause_menu.tscn")
@onready var ui_container = get_tree().current_scene.get_node("UIContainer")

func _unhandled_key_input(event):
	if event.is_action_pressed("Pause") and !ui_container.get_children():
		var new_pause_menu = pause_menu.instantiate()
		ui_container.add_child(new_pause_menu)
