extends "state.gd"

@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .2

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

var can_coyote_jump = true

func enter_state():
	if Player.prev_state == STATES.IDLE or Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE:
		can_coyote_jump = true
		CoyoteTimer.start(coyote_duration)
	else: 
		can_coyote_jump = false

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	
	start_jump_buffer_timer()
	
	if Player.is_on_floor() and Player.velocity.x == 0:
		return STATES.IDLE
	if Player.is_on_floor() and Player.velocity.x != 0:
		return STATES.MOVE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.is_on_wall_only():
		return STATES.SLIDE
	if Player.jump_input_actuation and Player.can_air_jump:
		return STATES.AIR_JUMP
	if Player.jump_input_actuation and can_coyote_jump:
		return STATES.JUMP
	return null

func _on_coyote_timer_timeout():
	can_coyote_jump = false

func start_jump_buffer_timer():
	if Player.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if Player.current_state == STATES.FALL or Player.current_state == STATES.SLIDE or Player.current_state == STATES.AIR_JUMP:
		Player.jump_buffer = false
	else:
		Player.jump_buffer = true
