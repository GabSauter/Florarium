extends "state.gd"

@export var JUMP_OFF_WALL_POWER = 1200

func enter_state():
	Player.velocity.x = JUMP_OFF_WALL_POWER * Player.get_wall_normal()[0]
	Player.velocity.y = Player.JUMP_VELOCITY

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.jump_input_actuation and Player.can_air_jump:
		return STATES.AIR_JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null
