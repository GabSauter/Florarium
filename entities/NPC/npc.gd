extends Area2D

@onready var label: RichTextLabel = $RichTextLabel
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var audio: AudioStream
@export_multiline var text: String
@export var sprites: SpriteFrames

func _ready() -> void:
	audio_stream_player_2d.stream = audio
	label.visible = false
	label.text = text
	
	calculate_label_size()
	
	animated_sprite.sprite_frames = sprites
	animated_sprite.play()
	
	var current_texture = sprites.get_frame_texture("default", 0)
	if current_texture:
		var sprite_height = current_texture.get_size().y
		var label_size = label.get_rect().size
		label.position = Vector2(label.position.x - label.size.x - 20, animated_sprite.position.y - sprite_height / 2 - label_size.y)

func calculate_label_size():
	var frases = label.text.split("\n")
	var reduce_frase_0 = frases[0].right(-27) #Remove the markups
	frases[0] = reduce_frase_0
	var max_line_length = 0
	for frase_index in range(0, frases.size()):
		if frases[frase_index].length() > max_line_length:
			max_line_length = frases[frase_index].length()
	label.size = Vector2(max_line_length * 9, frases.size() * 30)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_stream_player_2d.play()
		label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		label.visible = false
