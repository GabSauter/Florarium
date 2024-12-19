extends "state.gd"

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var common_behaviours: Node2D = $"../../CommonBehaviours"

var jump_dust_particles_scene = preload("res://particles/jump_dust_particles.tscn")

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

func enter_state():
	audio_stream_player_2d.play()
	var jump_dust_particles = jump_dust_particles_scene.instantiate()
	jump_dust_particles.position = player.position
	jump_dust_particles.emitting = true
	player.get_parent().add_child(jump_dust_particles)
	
	player.velocity.y = ((2.0 * player.movement.JUMP_HEIGHT) / player.movement.JUMP_TIME_TO_PEAK) * -1.0

func update(delta):
	player.animated_sprite.play("jump")
	
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
	cut_jump_height()
	start_jump_buffer_timer()
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.velocity.y > 0:
		return STATES.FALL
	if player.is_on_wall_only():
		return STATES.SLIDE
	if player.input_handler.dash_input and player.can_dash:
		return STATES.DASH
	return null

func cut_jump_height():
	if player.input_handler.cut_jump_input:
		if player.velocity.y < 0:
			player.velocity.y *= player.movement.CUT_JUMP_HEIGHT

func start_jump_buffer_timer():
	if player.input_handler.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if player.STATES.current_state == STATES.IDLE or player.STATES.current_state == STATES.MOVE or player.STATES.current_state == STATES.SLIDE:
		player.jump_buffer = true
	else:
		player.jump_buffer = false
