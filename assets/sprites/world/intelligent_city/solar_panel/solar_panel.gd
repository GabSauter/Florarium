extends Node2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start(3)

func _on_timer_timeout() -> void:
	animation.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	animation.stop()
	timer.start(3)
