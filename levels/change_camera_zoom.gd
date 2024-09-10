extends Area2D

@export var camera: PhantomCamera2D
@export var zoom: Vector2

func _on_body_entered(body):
	if body is Player:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "zoom", zoom, 1)
