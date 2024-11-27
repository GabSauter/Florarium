extends "state.gd"

func enter_state():
	player.velocity.x = player.movement.JUMP_OFF_WALL_POWER * player.get_wall_normal()[0]
	player.velocity.y = player.movement.JUMP_VELOCITY

func update(delta):
	player.animated_sprite.play("jump")
	
	player.gravity(delta)
	player_movement(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.is_on_wall():
		return STATES.SLIDE
	if player.velocity.y > 0:
		return STATES.FALL
	if player.dash_input and player.can_dash:
		return STATES.DASH
	return null
