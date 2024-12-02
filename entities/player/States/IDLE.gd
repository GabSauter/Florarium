extends "state.gd"

func enter_state():
	player.can_dash = true

func update(delta):
	player.animated_sprite.play("idle")
	
	player.calc_gravity(delta)
	player.velocity.x = move_toward(player.velocity.x, 0, player.movement.FRICTION * delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.jump_input_actuation == true or player.jump_buffer:
		player.jump_buffer = false
		return STATES.JUMP
	if player.movement_input.x != 0:
		return STATES.MOVE
	if player.velocity.y > 0:
		return STATES.FALL
	if player.dash_input and player.can_dash:
		return STATES.DASH
	return null
