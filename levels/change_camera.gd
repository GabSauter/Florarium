extends Area2D

@export var camera_in: PhantomCamera2D
@export var camera_out: PhantomCamera2D

func _on_body_entered(body):
	if body is Player:
		camera_in.priority = 100
		camera_out.priority = 0

func _on_body_exited(body):
	camera_in.priority = 0
	camera_out.priority = 100
