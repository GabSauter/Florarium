extends "state.gd"

func enter_state():
	Player.velocity.x = Player.velocity.x - cos(Player.bounce_rotation + PI/2) * Player.bounce_force
	Player.velocity.y = -sin(Player.bounce_rotation + PI/2) * Player.bounce_force
	Player.can_dash = true
	Player.bounce = false

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	
	if Player.dead:
		return STATES.DIE
	
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.is_on_wall_only():
		return STATES.SLIDE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.is_on_floor():
		return STATES.MOVE
	return null
