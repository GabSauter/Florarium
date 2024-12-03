class_name LevelContainer extends Node2D

@onready var level_transition_animation: AnimationPlayer = $"../LevelTransition/AnimationPlayer"
@onready var level_transition_canvas: CanvasLayer = $"../LevelTransition/CanvasLayer"
@onready var audio_stream_player: AudioStreamPlayer2D = $"../AudioMusicManager"

var new_scene_instance: Node

func next_level(next_level_scene):
	if self.get_child_count() > 0:
		var current_scene = self.get_child(0)
		
		level_transition_canvas.visible = true
		level_transition_animation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		current_scene.queue_free()
	
	call_deferred("_deferred_add_child", next_level_scene)

func _deferred_add_child(next_level_scene):
	new_scene_instance = next_level_scene.instantiate()
	self.add_child(new_scene_instance)
	audio_stream_player.play_music()
	await get_tree().create_timer(1.5).timeout
	level_transition_animation.play("fade_out")
	await get_tree().create_timer(1).timeout
	level_transition_canvas.visible = false
