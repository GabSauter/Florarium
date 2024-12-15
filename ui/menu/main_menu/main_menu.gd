class_name MainMenu
extends Control

var levelContainer: LevelContainer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var options_menu = $OptionsMenu

@onready var new_game_button = $MarginContainer/VBoxContainer/NewGameButton
@onready var options_button = $MarginContainer/VBoxContainer/OptionsButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton

@export var new_game_scene: PackedScene

func _ready():
	levelContainer = get_tree().current_scene.get_node("LevelContainer")

func _on_start_button_button_down():
	disable_buttons()
	levelContainer.next_level(new_game_scene)
	audio_stream_player.play()
	await audio_stream_player.finished
	self.queue_free()

func _on_options_button_button_down():
	disable_buttons()
	options_menu.visible = true
	audio_stream_player.play()
	options_menu.set_process(true)

func _on_quit_button_button_down():
	disable_buttons()
	audio_stream_player.play()
	await audio_stream_player.finished
	get_tree().quit()

func disable_buttons():
	quit_button.disabled = true
	options_button.disabled = true
	new_game_button.disabled = true

func enable_buttons():
	quit_button.disabled = false
	options_button.disabled = false
	new_game_button.disabled = false
