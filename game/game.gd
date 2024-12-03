class_name Game extends Node2D

@onready var audio_music_manager: AudioStreamPlayer2D = $AudioMusicManager

func _ready() -> void:
	audio_music_manager.play_music()
