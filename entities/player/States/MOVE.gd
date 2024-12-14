extends "state.gd"

@onready var common_behaviours: Node2D = $"../../CommonBehaviours"

func enter_state():
	player.can_dash = true

func update(delta):
	player.animated_sprite.play("run")
	
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.input_handler.movement_input == Vector2.ZERO:
		return STATES.IDLE
	if player.velocity.y >0:
		return STATES.FALL
	if player.input_handler.jump_input_actuation or player.jump_buffer:
		player.jump_buffer = false
		return STATES.JUMP
	if player.input_handler.dash_input and player.can_dash:
		return STATES.DASH
	return null
