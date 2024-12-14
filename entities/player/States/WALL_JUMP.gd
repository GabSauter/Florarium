extends "state.gd"

@onready var common_behaviours: Node2D = $"../../CommonBehaviours"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func enter_state():
	audio_stream_player_2d.play()
	player.animated_sprite.play("jump")
	player.velocity.x = player.movement.JUMP_OFF_WALL_POWER * player.get_wall_normal()[0]
	player.velocity.y = player.movement.JUMP_VELOCITY

func update(delta):
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.is_on_wall():
		return STATES.SLIDE
	if player.velocity.y > 0:
		return STATES.FALL
	if player.input_handler.dash_input and player.can_dash:
		return STATES.DASH
	return null
