extends "state.gd"

func enter_state():
	Player.can_dash = true

func update(delta):
	Player.gravity(delta)
	Player.velocity.x = move_toward(Player.velocity.x, 0, Player.movement.FRICTION * delta)
	
	if Player.dead:
		return STATES.DIE
	
	if Player.movement_input.x != 0:
		return STATES.MOVE
	if Player.jump_input_actuation == true or Player.jump_buffer:
		Player.jump_buffer = false
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null
