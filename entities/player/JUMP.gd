extends "state.gd"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	cut_jump_height()
	if Player.jump_input_actuation and Player.can_air_jump:
		return STATES.AIR_JUMP
	if Player.velocity.y >0:
		return STATES.FALL
	if Player.is_on_wall_only():
		return STATES.SLIDE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func enter_state():
	Player.velocity.y = Player.JUMP_VELOCITY

func cut_jump_height():
	if Player.cut_jump_input:
		if Player.velocity.y < 0:
			Player.velocity.y *= Player.CUT_JUMP_HEIGHT
