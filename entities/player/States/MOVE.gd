extends "state.gd"

func enter_state():
	player.can_dash = true

func update(delta):
	player.animated_sprite.play("run")
	
	player.gravity(delta)
	player_movement(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.movement_input == Vector2.ZERO:
		return STATES.IDLE
	if player.velocity.y >0:
		return STATES.FALL
	if player.jump_input_actuation or player.jump_buffer:
		player.jump_buffer = false
		return STATES.JUMP
	if player.dash_input and player.can_dash:
		return STATES.DASH
	return null
