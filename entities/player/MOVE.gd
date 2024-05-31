extends "state.gd"

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.movement_input == Vector2.ZERO:
		return STATES.IDLE
	if Player.velocity.y >0:
		return STATES.FALL
	if Player.jump_input_actuation or Player.jump_buffer:
		Player.jump_buffer = false
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func enter_state():
	Player.can_dash = true
	Player.can_air_jump = true
