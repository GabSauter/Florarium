extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_tab_container_tab_clicked(_index: int) -> void:
	audio_stream_player.play()
