extends "state.gd"

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite"

func enter_state():
	if player.velocity.y > 0:
		player.velocity.y *= .5

func update(delta):
	player.animated_sprite.play("slide")
	#var slide_sprites = player.animated_sprite.sprite_frames["slide"]
	
	if player.get_wall_normal().x > 0 and player.is_on_wall_only():
		player.animated_sprite.position.x = 10
	elif player.get_wall_normal().x < 0 and player.is_on_wall_only():
		player.animated_sprite.position.x = 0
	
	player_movement(delta)
	player.calc_gravity(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if !player.is_on_wall_only():
		return STATES.FALL
	if player.jump_input_actuation or player.jump_buffer:
		player.jump_buffer = false
		return STATES.WALL_JUMP
	if player.is_on_floor():
		return STATES.IDLE
	if player.dash_input and player.can_dash:
		return STATES.DASH
	return null
