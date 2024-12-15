class_name Game extends Node2D

@onready var audio_music_manager: AudioStreamPlayer = $AudioMusicManager

func _ready() -> void:
	audio_music_manager.play_music("main_menu")
