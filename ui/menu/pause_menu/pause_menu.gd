extends Control

@onready var ui_container = get_tree().current_scene.get_node("UIContainer")
@onready var level_container = get_tree().current_scene.get_node("LevelContainer")

@onready var options_menu = $OptionsMenu
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	audio_stream_player.play()
	get_tree().paused = true
	options_menu.set_process(false)

func _on_button_continue_pressed():
	audio_stream_player.play()
	get_tree().paused = false
	self.queue_free()

func _on_button_options_pressed():
	audio_stream_player.play()
	options_menu.set_process(true)
	options_menu.show()

func _on_button_left_to_menu_pressed():
	audio_stream_player.play()
	var main_menu = preload("res://ui/menu/main_menu/main_menu.tscn")
	ui_container.next_ui(main_menu)
	
	# save game
	
	clear_level_container()
	
	get_tree().paused = false
	self.queue_free()

func clear_level_container():
	var children = level_container.get_children()
	for child in children:
		level_container.remove_child(child)
		child.queue_free()
