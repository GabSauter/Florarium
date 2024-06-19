extends "state.gd"

func enter_state():
	if Player.velocity.y > 0 and Player.prev_state != STATES.FALL:
		Player.velocity.y = 1

func update(delta):
	player_movement(delta)
	Player.gravity(delta)
	
	if Player.dead:
		return STATES.DIE
	
	if Player.bounce:
		return STATES.BOUNCE
	
	if !Player.is_on_wall_only():
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.WALL_JUMP
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null
