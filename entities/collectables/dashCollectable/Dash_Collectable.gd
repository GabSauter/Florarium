extends Node2D

@onready var timer = $Timer
var timer_duration = 5

@onready var sprite = $Sprite2D
@onready var area_2d = $Area2D

func _on_area_2d_body_entered(body):
	if body is Player:
		body.can_dash = true
		
		sprite.visible = false
		area_2d.set_collision_mask_value(1, false)
		
		timer.start(timer_duration)

func _on_timer_timeout():
	sprite.visible = true
	area_2d.set_collision_mask_value(1, true)
