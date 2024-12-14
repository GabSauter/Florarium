extends "state.gd"

@onready var common_behaviours: Node2D = $"../../CommonBehaviours"

func enter_state():
	player.velocity.x = player.velocity.x - cos(player.bounce_rotation + PI/2) * player.bounce_force
	player.velocity.y = -sin(player.bounce_rotation + PI/2) * player.bounce_force
	player.can_dash = true
	player.bounce = false

func update(delta):
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.velocity.y > 0:
		return STATES.FALL
	if player.is_on_wall_only():
		return STATES.SLIDE
	if player.input_handler.dash_input and player.can_dash:
		return STATES.DASH
	if player.is_on_floor():
		return STATES.MOVE
	return null
