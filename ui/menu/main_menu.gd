class_name MainMenu
extends Control

@onready var game = $"../.."

@onready var options_menu = $OptionsMenu

@onready var new_game_button = $MarginContainer/VBoxContainer/NewGameButton
@onready var options_button = $MarginContainer/VBoxContainer/OptionsButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton

@export var new_game_scene: PackedScene

func _on_start_button_button_down():
	var level1 = preload("res://levels/level_1.tscn")
	game.next_scene(level1)

func _on_options_button_button_down():
	options_menu.visible = true
	options_menu.set_process(true)

func _on_quit_button_button_down():
	get_tree().quit()


