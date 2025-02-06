extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

const RESOLUTION_DICTIONARY = {
	"1280 x 720" : Vector2i(1280,720),
	"1440 x 900"  : Vector2i(1440,900),
	"1920 x 1080" : Vector2i(1920,1080)
}

func _ready():
	add_resolution_items()
	option_button.item_selected.connect(on_resolution_mode_selected)
	load_data()

func load_data():
	on_resolution_mode_selected(SettingsDataContainer.get_resolution_index())
	option_button.select(SettingsDataContainer.get_resolution_index())

func add_resolution_items():
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)

func on_resolution_mode_selected(index: int):
	SettingsSignalBus.emit_on_resolution_selected(index)
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	center_window()

func center_window():
	var centre_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_screen - window_size/2)

func _on_option_button_button_down() -> void:
	audio_stream_player.play()

func _on_option_button_item_selected(_index: int) -> void:
	audio_stream_player.play()
