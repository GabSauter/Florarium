extends TabBar

@onready var master_h_slider = $MarginContainer/AudioBoxContainer/GridContainer/MasterHSlider
@onready var music_h_slider = $MarginContainer/AudioBoxContainer/GridContainer/MusicHSlider
@onready var sfxh_slider = $MarginContainer/AudioBoxContainer/GridContainer/SFXHSlider

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

func _ready():
	load_data()

func load_data():
	master_h_slider.value = SettingsDataContainer.get_master_volume()
	_on_master_h_slider_value_changed(master_h_slider.value)
	
	music_h_slider.value = SettingsDataContainer.get_music_volume()
	_on_music_h_slider_value_changed(music_h_slider.value)
	
	sfxh_slider.value = SettingsDataContainer.get_sfx_volume()
	_on_sfxh_slider_value_changed(sfxh_slider.value)

func _on_master_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)
	
	SettingsSignalBus.emit_on_master_sound_set(value)

func _on_music_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
	
	SettingsSignalBus.emit_on_music_sound_set(value)

func _on_sfxh_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)
	
	SettingsSignalBus.emit_on_sfx_sound_set(value)
