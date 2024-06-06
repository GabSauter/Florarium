extends "state.gd"

func enter_state():
	Player.velocity.x = Player.movement.JUMP_OFF_WALL_POWER * Player.get_wall_normal()[0]
	Player.velocity.y = Player.movement.JUMP_VELOCITY

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	if Player.is_on_wall():
		return STATES.SLIDE
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null
