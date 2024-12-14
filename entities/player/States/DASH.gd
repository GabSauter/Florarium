extends "state.gd"

@export var dash_direction = Vector2.ZERO

@onready var DashDuration_timer = $DashDuration
@onready var ghost_timer = $GhostTimer
@onready var particles = $GPUParticles2D
@onready var pause_game_timer: Timer = $PauseGameTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var ghost_scene = preload("res://entities/player/effects/dash_ghost.tscn")

@onready var camera_host: PhantomCameraHost = get_node("/root/Game/Camera2D/PhantomCameraHost")

var camera: PhantomCamera2D
var shake_intensity = 2.5
var shake_duration = 0.2
var shake_time = 0.0

var dashing = false

func enter_state():
	#pause_game()
	audio_stream_player_2d.play()
	emit_particles()
	
	player.can_dash = false
	dashing = true
	DashDuration_timer.start(player.movement.dash_duration)
	if player.input_handler.movement_input != Vector2.ZERO:
		dash_direction = player.input_handler.movement_input
	else:
		dash_direction = player.input_handler.last_direction
	
	handle_dash_velocity_on_different_directions()
	start_ghost()
	
	start_camera_shake()

func update(delta):
	if player.dead:
		return STATES.DIE
	
	if player.is_on_floor() and (player.input_handler.jump_input_actuation or player.jump_buffer):
		player.jump_buffer = false
		player.can_dash = true
		return STATES.JUMP
	
	if player.bounce:
		return STATES.BOUNCE
	
	if !dashing:
		return STATES.FALL
	
	if shake_time > 0.0:
		shake_time -= delta
		apply_camera_shake()
	
	return null

func exit_state():
	stop_ghost()
	particles.emitting = false
	dashing = false

func handle_dash_velocity_on_different_directions():
	if player.input_handler.movement_input in [Vector2(1, 0), Vector2(-1, 0)]:
		player.velocity = dash_direction.normalized() * player.movement.dash_speed_x
	elif player.input_handler.movement_input in [Vector2(0, 1), Vector2(0, -1)]:
		player.velocity = dash_direction.normalized() * player.movement.dash_speed_y
	else:
		player.velocity = dash_direction.normalized() * player.movement.dash_speed_diagonal

func instance_ghost():
	var ghost = ghost_scene.instantiate()
	
	var frameIndex: int = player.animated_sprite.get_frame()
	var animationName: String = player.animated_sprite.animation
	var spriteFrames: SpriteFrames = player.animated_sprite.get_sprite_frames()
	var currentTexture: Texture2D = spriteFrames.get_frame_texture(animationName, frameIndex)
	
	ghost.texture = currentTexture
	ghost.global_position = self.global_position
	ghost.flip_h = player.animated_sprite.flip_h
	
	player.get_parent().add_child(ghost)

func start_ghost():
	instance_ghost()
	ghost_timer.start()
	player.animated_sprite.material.set_shader_parameter("mix_weight", 0.7)
	player.animated_sprite.material.set_shader_parameter("whiten", true)

func stop_ghost():
	ghost_timer.stop()
	player.animated_sprite.material.set_shader_parameter("whiten", false)

func emit_particles():
	particles.emitting = true
	particles.process_material.direction = Vector3(-player.input_handler.movement_input.x,-player.input_handler.movement_input.y,0)

func _on_dash_duration_timeout():
	dashing = false

func _on_ghost_timer_timeout():
	instance_ghost()

func start_camera_shake():
	if camera_host != null:
		camera = camera_host._active_pcam_2d
		shake_time = shake_duration

func apply_camera_shake():
	if camera:
		var offset = Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))
		camera.position += offset

#func pause_game():
	#pause_game_timer.start(0.03)
	#get_tree().paused = true
#
#func _on_pause_game_timer_timeout() -> void:
	#get_tree().paused = false
