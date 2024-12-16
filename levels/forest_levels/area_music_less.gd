extends Area2D

@onready var audio_music_manager : AudioStreamPlayer = get_tree().current_scene.get_node("AudioMusicManager")
var fade_speed: float = 0.2
var fading_out: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player and audio_music_manager != null:
		fading_out = true

func _process(delta: float) -> void:
	if fading_out and audio_music_manager.volume_db > -60.0:
		audio_music_manager.volume_db = lerp(audio_music_manager.volume_db, -60.0, fade_speed * delta)
		if audio_music_manager.volume_db <= -59.9:
			fading_out = false
