extends "state.gd"

func update(delta):
	player.gravity(delta)
	player_movement(delta)
	cut_jump_height()
	if player.velocity.y > 0:
		return STATES.FALL
	if player.dash_input and player.can_dash:
		return STATES.DASH
	return null

func enter_state():
	player.can_air_jump = false
	player.velocity.y = player.movement.JUMP_VELOCITY

func cut_jump_height():
	if player.cut_jump_input:
		if player.velocity.y < 0:
			player.velocity.y *= player.movement.CUT_JUMP_HEIGHT
