extends "state.gd"

@onready var common_behaviours: Node2D = $"../../CommonBehaviours"

func update(delta):
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
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
