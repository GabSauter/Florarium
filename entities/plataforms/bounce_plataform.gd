extends Area2D

@export var bounce_force = 2000

func _on_body_entered(body):
	if body is Player:
		body.bounce_rotation = rotation
		body.bounce_force = bounce_force
		body.bounce = true
