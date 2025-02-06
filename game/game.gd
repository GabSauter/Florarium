class_name Game extends Node2D

@onready var music_manager: AudioStreamPlayer = $MusicManager

func _ready() -> void:
	music_manager.play_music("main_menu")
