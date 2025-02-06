extends Area2D

@onready var music_manager : AudioStreamPlayer = get_tree().current_scene.get_node("MusicManager")
var fade_speed: float = 0.2
var fading_out: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player and music_manager != null:
		fading_out = true

func _process(delta: float) -> void:
	if fading_out and music_manager.volume_db > -60.0:
		music_manager.volume_db = lerp(music_manager.volume_db, -60.0, fade_speed * delta)
		if music_manager.volume_db <= -59.9:
			fading_out = false
