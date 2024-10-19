extends "state.gd"

@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .25

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

var can_coyote_jump = true

func enter_state():
	handle_can_coyote_jump()

func update(delta):
	Player.animated_sprite.play("fall")
	
	Player.gravity(delta)
	player_movement(delta)
	
	start_jump_buffer_timer()
	
	if Player.dead:
		return STATES.DIE
	
	if Player.bounce:
		return STATES.BOUNCE
	
	if Player.is_on_floor() and Player.velocity.x == 0:
		return STATES.IDLE
	if Player.is_on_floor() and Player.velocity.x != 0:
		return STATES.MOVE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.is_on_wall_only():
		return STATES.SLIDE
	if Player.jump_input_actuation and can_coyote_jump:
		if Player.prev_state == STATES.SLIDE:
			return STATES.WALL_JUMP
		return STATES.JUMP
		
	return null

func handle_can_coyote_jump():
	if Player.prev_state == STATES.IDLE or Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE or Player.prev_state == STATES.DASH:
		can_coyote_jump = true
		CoyoteTimer.start(coyote_duration)
	else: 
		can_coyote_jump = false

func _on_coyote_timer_timeout():
	can_coyote_jump = false

func start_jump_buffer_timer():
	if Player.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if Player.current_state == STATES.IDLE or Player.current_state == STATES.MOVE or Player.current_state == STATES.SLIDE:
		Player.jump_buffer = true
	else:
		Player.jump_buffer = false
