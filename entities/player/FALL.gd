extends "state.gd"

@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .2

var can_coyote_jump = true

func update(delta):
	Player.gravity(delta)
	player_movement(delta)
	
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

func enter_state():
	if Player.prev_state == STATES.IDLE or Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE:
		can_coyote_jump = true
		CoyoteTimer.start(coyote_duration)
	else: 
		can_coyote_jump = false

func _on_coyote_timer_timeout():
	can_coyote_jump = false
