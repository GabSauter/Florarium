extends Node2D

@onready var player: Player = $"../Player"
@onready var sprite_2d: Sprite2D = $Sprite2D

var noise: FastNoiseLite = FastNoiseLite.new()
var noise_offset := Vector2(randf() * 150, randf() * 150)
var noise_scale: float = 15.0
var noise_speed: float = 2.0
var follow_speed: float = 5.5

func _ready() -> void:
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.frequency = 0.8

func _process(delta: float) -> void:
	if player.can_dash:
		sprite_2d.modulate = Color.AQUAMARINE
	else:
		sprite_2d.modulate = Color.BISQUE
	
	# Calculate noise-based offset
	var time_offset = float(Time.get_ticks_msec()) / 1000.0 * noise_speed
	var x_offset = noise.get_noise_2d(noise_offset.x, time_offset)
	var y_offset = noise.get_noise_2d(noise_offset.y, time_offset)
	var noise_position = Vector2(x_offset * noise_scale, y_offset * noise_scale)

	# Target position with noise applied
	var target_position
	if player.input_handler.last_direction.x > 0:
		target_position = player.position + noise_position + Vector2(-45,-10)
	else:
		target_position = player.position + noise_position + Vector2(45,-10)

	# Smoothly move towards the target position
	position = position.lerp(target_position, follow_speed * delta)
