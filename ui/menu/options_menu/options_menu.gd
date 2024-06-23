extends Control

func _ready():
	self.set_process(false)

func _on_back_button_button_down():
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	self.visible = false
	self.set_process(false)
