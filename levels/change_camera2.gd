extends Area2D

@export var camera_in: PhantomCamera2D
@onready var phantom_camera_host: PhantomCameraHost = $"../../../Camera2D/PhantomCameraHost"
#@onready var phantom_camera_host = $"../Camera2D/PhantomCameraHost"

func _on_body_entered(body):
	if body is Player:
		if phantom_camera_host != null:
			camera_in.priority = phantom_camera_host._active_pcam_priority+1
		else:
			Camera2D.new()
