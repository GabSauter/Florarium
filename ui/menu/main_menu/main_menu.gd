class_name MainMenu
extends Control

var levelContainer: LevelContainer

@onready var options_menu = $OptionsMenu

@onready var new_game_button = $MarginContainer/VBoxContainer/NewGameButton
@onready var options_button = $MarginContainer/VBoxContainer/OptionsButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton

@export var new_game_scene: PackedScene

func _ready():
	levelContainer = get_tree().current_scene.get_node("LevelContainer")

func _on_start_button_button_down():
	var level1 = preload("res://levels/forest_levels/level_1.tscn")
	levelContainer.next_level(level1)
	
	self.queue_free()

func _on_options_button_button_down():
	options_menu.visible = true
	options_menu.set_process(true)

func _on_quit_button_button_down():
	get_tree().quit()
