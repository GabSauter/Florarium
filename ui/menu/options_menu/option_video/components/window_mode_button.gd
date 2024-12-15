extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

const WINDOW_MODE_ARRAY = [
	"Full-Screen",
	"Window Mode",
	"Bordeless Window",
	"Bordeless Full-Screen"
]

func _ready():
	add_window_mode_item()
	option_button.item_selected.connect(on_window_mode_selected)
	load_data()

func load_data():
	on_window_mode_selected(SettingsDataContainer.get_window_mode_index())
	option_button.select(SettingsDataContainer.get_window_mode_index())

func add_window_mode_item():
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)

func on_window_mode_selected(index: int):
	SettingsSignalBus.emit_on_window_mode_selected(index)
	match index:
		0: #Full-Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Bordeless Window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Bordeless Full-Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func _on_option_button_button_down() -> void:
	audio_stream_player.play()

func _on_option_button_item_selected(index: int) -> void:
	audio_stream_player.play()
