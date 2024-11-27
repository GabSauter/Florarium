class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var STATES = $STATES

@export var movement: PlayerMovementData

#player input
var last_direction = Vector2.RIGHT
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var cut_jump_input = false
var dash_input = false

#mechanics
var can_dash = true

#states
var current_state = null
var prev_state = null

#buffer
var jump_buffer = false

var dead = false
var respawn_position: Vector2

var bounce = false
var bounce_rotation
var bounce_force

func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE

func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	move_and_slide()

func gravity(delta):
	if not is_on_floor():
		var gravity
		if abs(velocity.y) < movement.APEX_RANGE:
			gravity = movement.APEX_GRAVITY
		elif current_state == STATES.FALL:
			gravity = movement.FALL_GRAVITY
		elif current_state == STATES.SLIDE and velocity.y > 0:
			gravity = movement.SLIDE_GRAVITY
		else:
			gravity = movement.JUMP_GRAVITY
		
		if velocity.y > movement.MAX_FALL_SPEED:
			velocity.y = movement.MAX_FALL_SPEED
		else:
			velocity.y += gravity * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		animated_sprite.flip_h = true
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		animated_sprite.flip_h = false
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
		goDownFromOneWayPlataform()
	
	# jumps
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else:
		jump_input = false
	if Input.is_action_just_released("Jump"):
		cut_jump_input = true
	else:
		cut_jump_input = false
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false
	
	#dash
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
	else:
		dash_input = false

func goDownFromOneWayPlataform():
	if is_on_floor():
			position.y += 1
