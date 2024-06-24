extends Node

@onready var DEFAULT_SETTINGS: DefaultSettingsResource = preload("res://game/managers/settings/resource/default_settings_resource.tres")
@onready var KEYBIND_DEFAULT: KeybindResource = preload("res://game/managers/settings/resource/keybind_default_resource.tres")

var window_mode_index: int = 0
var resolution_index: int = 0

var master_volume: float = 0.0
var music_volume: float = 0.0
var sfx_volume: float = 0.0

var loaded_data: Dictionary = {}

func _ready():
	handle_signals()
	create_storage_dictionary()

func create_storage_dictionary() -> Dictionary:
	var settings_container_dict = {
		"window_mode_index": window_mode_index,
		"resolution_index" : resolution_index,
		"master_volume": master_volume,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		
		"keybinds": create_keybind_dict()
	}
	
	return settings_container_dict

func create_keybind_dict():
	var keybinds_container_dict = {
		KEYBIND_DEFAULT.MOVE_LEFT: KEYBIND_DEFAULT.move_left_key,
		KEYBIND_DEFAULT.MOVE_RIGHT: KEYBIND_DEFAULT.move_right_key,
		KEYBIND_DEFAULT.MOVE_UP: KEYBIND_DEFAULT.move_up_key,
		KEYBIND_DEFAULT.MOVE_DOWN: KEYBIND_DEFAULT.move_down_key,
		KEYBIND_DEFAULT.JUMP: KEYBIND_DEFAULT.jump_key,
		KEYBIND_DEFAULT.DASH: KEYBIND_DEFAULT.dash_key,
		KEYBIND_DEFAULT.PAUSE: KEYBIND_DEFAULT.pause_key,
	}
	
	return keybinds_container_dict

func get_window_mode_index():
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_WINDOW_MODE_INDEX
	return window_mode_index

func get_resolution_index():
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_RESOLUTION_INDEX
	return resolution_index

func get_master_volume():
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MASTER_VOLUME
	return master_volume

func get_music_volume():
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MUSIC_VOLUME
	return music_volume

func get_sfx_volume():
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SFX_VOLUME
	return sfx_volume

func get_keybind(action: String):
	if !loaded_data.has("keybinds"):
		match action:
			KEYBIND_DEFAULT.MOVE_LEFT:
				return KEYBIND_DEFAULT.DEFAULT_MOVE_LEFT_KEY
			KEYBIND_DEFAULT.MOVE_RIGHT:
				return KEYBIND_DEFAULT.DEFAULT_MOVE_RIGHT_KEY
			KEYBIND_DEFAULT.MOVE_UP:
				return KEYBIND_DEFAULT.DEFAULT_MOVE_UP_KEY
			KEYBIND_DEFAULT.MOVE_DOWN:
				return KEYBIND_DEFAULT.DEFAULT_MOVE_DOWN_KEY
			KEYBIND_DEFAULT.JUMP:
				return KEYBIND_DEFAULT.DEFAULT_JUMP_KEY
			KEYBIND_DEFAULT.DASH:
				return KEYBIND_DEFAULT.DEFAULT_DASH_KEY
			KEYBIND_DEFAULT.PAUSE:
				return KEYBIND_DEFAULT.DEFAULT_PAUSE_KEY
	else:
		match action:
			KEYBIND_DEFAULT.MOVE_LEFT:
				return KEYBIND_DEFAULT.move_left_key
			KEYBIND_DEFAULT.MOVE_RIGHT:
				return KEYBIND_DEFAULT.move_right_key
			KEYBIND_DEFAULT.MOVE_UP:
				return KEYBIND_DEFAULT.move_up_key
			KEYBIND_DEFAULT.MOVE_DOWN:
				return KEYBIND_DEFAULT.move_down_key
			KEYBIND_DEFAULT.JUMP:
				return KEYBIND_DEFAULT.jump_key
			KEYBIND_DEFAULT.DASH:
				return KEYBIND_DEFAULT.dash_key
			KEYBIND_DEFAULT.PAUSE:
				return KEYBIND_DEFAULT.pause_key

func on_window_mode_selected(index: int):
	window_mode_index = index

func on_resolution_selected(index: int):
	resolution_index = index

func on_master_sound_set(value: float):
	master_volume = value

func on_music_sound_set(value: float):
	music_volume = value

func on_sfx_sound_set(value: float):
	sfx_volume = value

func set_keybind(action: String, event) -> void:
	match action:
		KEYBIND_DEFAULT.MOVE_LEFT:
			KEYBIND_DEFAULT.move_left_key = event
		KEYBIND_DEFAULT.MOVE_RIGHT:
			KEYBIND_DEFAULT.move_right_key = event
		KEYBIND_DEFAULT.MOVE_UP:
			KEYBIND_DEFAULT.move_up_key = event
		KEYBIND_DEFAULT.MOVE_DOWN:
			KEYBIND_DEFAULT.move_down_key = event
		KEYBIND_DEFAULT.JUMP:
			KEYBIND_DEFAULT.jump_key = event
		KEYBIND_DEFAULT.DASH:
			KEYBIND_DEFAULT.dash_key = event
		KEYBIND_DEFAULT.PAUSE:
			KEYBIND_DEFAULT.pause_key = event

func on_keybinds_loaded(data: Dictionary):
	var loaded_move_left = InputEventKey.new()
	var loaded_move_right = InputEventKey.new()
	var loaded_move_up = InputEventKey.new()
	var loaded_move_down = InputEventKey.new()
	var loaded_jump = InputEventKey.new()
	var loaded_dash = InputEventKey.new()
	var loaded_pause = InputEventKey.new()
	
	loaded_move_left.set_physical_keycode(int(data.MoveLeft))
	loaded_move_right.set_physical_keycode(int(data.MoveRight))
	loaded_move_up.set_physical_keycode(int(data.MoveUp))
	loaded_move_down.set_physical_keycode(int(data.MoveDown))
	loaded_jump.set_physical_keycode(int(data.Jump))
	loaded_dash.set_physical_keycode(int(data.Dash))
	loaded_pause.set_physical_keycode(int(data.Pause))
	
	KEYBIND_DEFAULT.move_left_key = loaded_move_left
	KEYBIND_DEFAULT.move_right_key = loaded_move_right
	KEYBIND_DEFAULT.move_up_key = loaded_move_up
	KEYBIND_DEFAULT.move_down_key = loaded_move_down
	KEYBIND_DEFAULT.jump_key = loaded_jump
	KEYBIND_DEFAULT.dash_key = loaded_dash
	KEYBIND_DEFAULT.pause_key = loaded_pause

func on_settings_data_loaded(data: Dictionary):
	loaded_data = data
	
	on_window_mode_selected(loaded_data.window_mode_index)
	on_resolution_selected(loaded_data.resolution_index)
	
	on_master_sound_set(loaded_data.master_volume)
	on_music_sound_set(loaded_data.music_volume)
	on_sfx_sound_set(loaded_data.sfx_volume)
	on_keybinds_loaded(loaded_data.keybinds)

func handle_signals():
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
