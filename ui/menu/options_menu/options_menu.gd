extends Control

@onready var main_menu = $".."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	self.set_process(false)

func _on_back_button_button_down():
	audio_stream_player.play()
	self.visible = false
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	if main_menu != null and main_menu is MainMenu:
		main_menu.enable_buttons()
	self.set_process(false)
