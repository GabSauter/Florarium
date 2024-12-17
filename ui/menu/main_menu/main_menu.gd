class_name MainMenu
extends Control

var levelContainer: LevelContainer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var options_menu = $OptionsMenu

@onready var confirm_new_game_painel: Control = $ConfirmNewGamePainel

@onready var new_game_button = $MarginContainer/VBoxContainer/NewGameButton
@onready var options_button = $MarginContainer/VBoxContainer/OptionsButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton
@onready var continue_game_button: Button = $MarginContainer/VBoxContainer/ContinueGameButton

var new_game_scene: PackedScene
var saved_game_scene: PackedScene

func _ready():
	confirm_new_game_painel.visible = false
	
	levelContainer = get_tree().current_scene.get_node("LevelContainer")
	
	new_game_scene = load("res://quiz/climatic_change_especific/climatic_change_quiz_1.tscn")
	
	continue_game_button.disabled = true
	var saved_game_level: String = load_saved_game_level_from_file()
	if saved_game_level != "":
		saved_game_scene = load(load_saved_game_level_from_file())

func load_saved_game_level_from_file() -> String:
	var file = FileAccess.open("user://SaveLevel.dat", FileAccess.READ)
	if file != null:
		var content = file.get_as_text()
		continue_game_button.disabled = false
		return content
	return ""

func _on_start_button_button_down():
	audio_stream_player.play()
	if saved_game_scene != null:
		confirm_new_game_painel.visible = true
	else:
		start_new_game()

func start_new_game():
	disable_buttons()
	levelContainer.next_level(new_game_scene)
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

func _on_continue_game_button_button_down() -> void:
	disable_buttons()
	levelContainer.next_level(saved_game_scene)
	audio_stream_player.play()
	await audio_stream_player.finished
	self.queue_free()

func disable_buttons():
	continue_game_button.disabled = true
	quit_button.disabled = true
	options_button.disabled = true
	new_game_button.disabled = true

func enable_buttons():
	if saved_game_scene != null:
		continue_game_button.disabled = false
	quit_button.disabled = false
	options_button.disabled = false
	new_game_button.disabled = false

func _on_button_no_button_down() -> void:
	audio_stream_player.play()
	confirm_new_game_painel.visible = false

func _on_button_yes_button_down() -> void:
	audio_stream_player.play()
	start_new_game()
