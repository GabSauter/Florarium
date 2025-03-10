extends Node2D

@onready var timer = $Timer
var timer_duration = 1.5

@onready var sprite = $Sprite2D
@onready var area_2d = $Area2D
@onready var particles = $GPUParticles2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_body_entered(body):
	if body is Player:
		audio_stream_player_2d.play()
		body.can_dash = true
		
		sprite.visible = false
		area_2d.set_collision_mask_value(1, false)
		
		timer.start(timer_duration)
		particles.emitting = false

func _on_timer_timeout():
	sprite.visible = true
	area_2d.set_collision_mask_value(1, true)
	particles.emitting = true
