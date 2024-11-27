extends "state.gd"

@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .25

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

var can_coyote_jump = true

func enter_state():
	handle_can_coyote_jump()

func update(delta):
	player.animated_sprite.play("fall")
	
	player.gravity(delta)
	player_movement(delta)
	
	start_jump_buffer_timer()
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.is_on_floor() and player.velocity.x == 0:
		return STATES.IDLE
	if player.is_on_floor() and player.velocity.x != 0:
		return STATES.MOVE
	if player.dash_input and player.can_dash:
		return STATES.DASH
	if player.is_on_wall_only():
		return STATES.SLIDE
	if player.jump_input_actuation and can_coyote_jump:
		if player.prev_state == STATES.SLIDE:
			return STATES.WALL_JUMP
		return STATES.JUMP
		
	return null

func handle_can_coyote_jump():
	if player.prev_state == STATES.IDLE or player.prev_state == STATES.MOVE or player.prev_state == STATES.SLIDE or player.prev_state == STATES.DASH:
		can_coyote_jump = true
		CoyoteTimer.start(coyote_duration)
	else: 
		can_coyote_jump = false

func _on_coyote_timer_timeout():
	can_coyote_jump = false

func start_jump_buffer_timer():
	if player.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if player.current_state == STATES.IDLE or player.current_state == STATES.MOVE or player.current_state == STATES.SLIDE:
		player.jump_buffer = true
	else:
		player.jump_buffer = false
