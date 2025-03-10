class_name HotkeyRebindButton extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var action_name: String = ""

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	load_keybinds()

func load_keybinds():
	rebind_action_key(SettingsDataContainer.get_keybind(action_name))

func set_action_name():
	label.text = "Unassigned"
	
	match action_name:
		"MoveLeft":
			label.text = "Mover para esquerda"
		"MoveRight":
			label.text = "Mover para direita"
		"MoveDown":
			label.text = "Baixo"
		"MoveUp":
			label.text = "Cima"
		"Jump":
			label.text = "Pular"
		"Dash":
			label.text = "Impulso"
		"Pause":
			label.text = "Pausar"

func set_text_for_key():
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode

func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Aperte um botão..."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		
		audio_stream_player.play()
		set_text_for_key()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false

func rebind_action_key(event):
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name,event)
		SettingsDataContainer.set_keybind(action_name, event)
		
		set_process_unhandled_key_input(false)
		set_text_for_key()
		set_action_name()

func _on_button_button_down() -> void:
	audio_stream_player.play()
