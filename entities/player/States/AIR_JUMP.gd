extends "state.gd"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	cut_jump_height()
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func enter_state():
	Player.can_air_jump = false
	Player.velocity.y = Player.movement.JUMP_VELOCITY

func cut_jump_height():
	if Player.cut_jump_input:
		if Player.velocity.y < 0:
			Player.velocity.y *= Player.movement.CUT_JUMP_HEIGHT
