extends "state.gd"

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite"

func enter_state():
	if Player.velocity.y > 0:
		Player.velocity.y *= .5

func update(delta):
	Player.animated_sprite.play("slide")
	#var slide_sprites = Player.animated_sprite.sprite_frames["slide"]
	
	if Player.get_wall_normal().x > 0 and Player.is_on_wall_only():
		Player.animated_sprite.position.x = 10
	elif Player.get_wall_normal().x < 0 and Player.is_on_wall_only():
		Player.animated_sprite.position.x = 0
	
	player_movement(delta)
	Player.gravity(delta)
	
	if Player.dead:
		return STATES.DIE
	
	if Player.bounce:
		return STATES.BOUNCE
	
	if !Player.is_on_wall_only():
		return STATES.FALL
	if Player.jump_input_actuation or Player.jump_buffer:
		Player.jump_buffer = false
		return STATES.WALL_JUMP
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null
