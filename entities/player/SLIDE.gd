extends "state.gd"

@export var JUMP_HEIGHT : float = 383
@export var JUMP_TIME_TO_DESCENT : float = 0.8
@onready var SLIDE_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1.0

func enter_state():
	Player.can_air_jump = true
	Player.velocity.y = 1

func update(delta):
	slide_movement(delta)
	if Player.is_on_wall_only() == false:
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.WALL_JUMP
	if Player.is_on_floor():
		return STATES.IDLE
	return null

func slide_movement(delta):
	player_movement(delta)
	
	Player.velocity.y += SLIDE_GRAVITY * delta
