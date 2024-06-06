extends "state.gd"

func enter_state():
	Player.velocity.y = Player.movement.JUMP_VELOCITY

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	cut_jump_height()
	
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.is_on_wall_only():
		return STATES.SLIDE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func cut_jump_height():
	if Player.cut_jump_input:
		if Player.velocity.y < 0:
			Player.velocity.y *= Player.movement.CUT_JUMP_HEIGHT
