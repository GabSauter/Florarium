extends "state.gd"

@export var dash_direction = Vector2.ZERO

@onready var DashDuration_timer = $DashDuration
@onready var ghost_timer = $GhostTimer
@onready var particles = $GPUParticles2D
@onready var pause_game_timer: Timer = $PauseGameTimer

var ghost_scene = preload("res://entities/player/effects/DashGhost.tscn")

@onready var camera_host: PhantomCameraHost = $"../../../../../../Camera2D/PhantomCameraHost"
var camera: PhantomCamera2D
var shake_intensity = 2.5
var shake_duration = 0.2
var shake_time = 0.0

var dashing = false

func enter_state():
	pause_game()
	emit_particles()
	
	Player.can_dash = false
	dashing = true
	DashDuration_timer.start(Player.movement.dash_duration)
	if Player.movement_input != Vector2.ZERO:
		dash_direction = Player.movement_input
	else:
		dash_direction = Player.last_direction
	
	handle_dash_velocity_on_different_directions()
	start_ghost()
	
	start_camera_shake()

func update(delta):
	if Player.dead:
		return STATES.DIE
	
	if Player.is_on_floor() and (Player.jump_input_actuation or Player.jump_buffer):
		Player.jump_buffer = false
		Player.can_dash = true
		return STATES.JUMP
	
	if Player.bounce:
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
	if Player.movement_input in [Vector2(1, 0), Vector2(-1, 0)]:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_x
	elif Player.movement_input in [Vector2(0, 1), Vector2(0, -1)]:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_y
	else:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_diagonal

func instance_ghost():
	var ghost = ghost_scene.instantiate()
	
	var frameIndex: int = Player.animated_sprite.get_frame()
	var animationName: String = Player.animated_sprite.animation
	var spriteFrames: SpriteFrames = Player.animated_sprite.get_sprite_frames()
	var currentTexture: Texture2D = spriteFrames.get_frame_texture(animationName, frameIndex)
	
	ghost.texture = currentTexture
	ghost.global_position = self.global_position
	ghost.flip_h = Player.animated_sprite.flip_h
	
	Player.get_parent().add_child(ghost)

func start_ghost():
	instance_ghost()
	ghost_timer.start()
	Player.animated_sprite.material.set_shader_parameter("mix_weight", 0.7)
	Player.animated_sprite.material.set_shader_parameter("whiten", true)

func stop_ghost():
	ghost_timer.stop()
	Player.animated_sprite.material.set_shader_parameter("whiten", false)

func emit_particles():
	particles.emitting = true
	particles.process_material.direction = Vector3(-Player.movement_input.x,-Player.movement_input.y,0)

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

func pause_game():
	pause_game_timer.start(0.03)
	get_tree().paused = true

func _on_pause_game_timer_timeout() -> void:
	get_tree().paused = false
