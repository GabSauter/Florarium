extends Area2D

@onready var label: RichTextLabel = $ColorRect/RichTextLabel
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export_multiline var text: String
@export var sprites: SpriteFrames

func _ready() -> void:
	label.visible = false
	label.text = text
	animated_sprite.sprite_frames = sprites
	animated_sprite.play()
	
	var current_texture = sprites.get_frame_texture("default", 0)
	if current_texture:
		var sprite_height = current_texture.get_size().y
		var label_size = label.get_rect().size
		label.position = Vector2(label.position.x - label.size.x + 50, animated_sprite.position.y - sprite_height / 2 - label_size.y + 50)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		label.visible = false
