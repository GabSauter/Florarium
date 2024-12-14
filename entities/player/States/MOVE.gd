extends "state.gd"

@onready var common_behaviours: Node2D = $"../../CommonBehaviours"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

var foot_step_frames = [1]

func enter_state():
	player.can_dash = true
	timer.start(0.5)
	play_footstep_audio()

func update(delta):
	if player.animated_sprite.frame in foot_step_frames:
		play_footstep_audio()
	player.animated_sprite.play("run")
	
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.input_handler.movement_input == Vector2.ZERO:
		return STATES.IDLE
	if player.velocity.y >0:
		return STATES.FALL
	if player.input_handler.jump_input_actuation or player.jump_buffer:
		player.jump_buffer = false
		return STATES.JUMP
	if player.input_handler.dash_input and player.can_dash:
		return STATES.DASH
	return null

func play_footstep_audio():
	audio_stream_player_2d.pitch_scale = randf_range(.8,1.2)
	audio_stream_player_2d.play()
