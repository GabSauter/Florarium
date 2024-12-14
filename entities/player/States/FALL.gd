extends "state.gd"

@onready var common_behaviours: Node2D = $"../../CommonBehaviours"

@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .25

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

var can_coyote_jump = true

func enter_state():
	handle_can_coyote_jump()
	player.animated_sprite.play("fall")

func update(delta):
	common_behaviours.calc_gravity(delta)
	common_behaviours.player_movement(delta)
	
	start_jump_buffer_timer()
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.is_on_floor() and player.velocity.x == 0:
		return STATES.IDLE
	if player.is_on_floor() and player.velocity.x != 0:
		return STATES.MOVE
	if player.input_handler.dash_input and player.can_dash:
		return STATES.DASH
	if player.is_on_wall_only():
		return STATES.SLIDE
	if player.input_handler.jump_input_actuation and can_coyote_jump:
		if player.STATES.prev_state == STATES.SLIDE:
			return STATES.WALL_JUMP
		return STATES.JUMP
		
	return null

func handle_can_coyote_jump():
	if player.STATES.prev_state == STATES.IDLE or player.STATES.prev_state == STATES.MOVE or player.STATES.prev_state == STATES.SLIDE or player.STATES.prev_state == STATES.DASH:
		can_coyote_jump = true
		CoyoteTimer.start(coyote_duration)
	else:
		can_coyote_jump = false

func _on_coyote_timer_timeout():
	can_coyote_jump = false

func start_jump_buffer_timer():
	if player.input_handler.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if player.STATES.current_state == STATES.IDLE or player.STATES.current_state == STATES.MOVE or player.STATES.current_state == STATES.SLIDE:
		player.jump_buffer = true
	else:
		player.jump_buffer = false
