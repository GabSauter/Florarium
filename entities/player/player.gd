extends CharacterBody2D
class_name Player

@onready var STATES = $STATES
@onready var labelState = $LabelState
@onready var labelGravity = $LabelGravity
@onready var labelVelocityY = $LabelVelocityY
@onready var labelVelocityX = $LabelVelocityX

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
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE

func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	labelState.text = str(current_state.get_name())
	labelVelocityY.text = str(velocity.y)
	labelVelocityX.text = str(velocity.x)
	move_and_slide()

func gravity(delta):
	if not is_on_floor():
		var get_gravity
		if abs(velocity.y) < movement.APEX_RANGE:
			labelGravity.text = str("Apex gravity")
			get_gravity = movement.APEX_GRAVITY
		elif current_state == STATES.FALL:
			labelGravity.text = str("Fall gravity")
			get_gravity = movement.FALL_GRAVITY
		elif current_state == STATES.SLIDE and velocity.y > 0:
			labelGravity.text = str("Slide gravity")
			get_gravity = movement.SLIDE_GRAVITY
		else:
			labelGravity.text = str("Normal gravity")
			get_gravity = movement.JUMP_GRAVITY
		
		if velocity.y > movement.MAX_FALL_SPEED:
			velocity.y = movement.MAX_FALL_SPEED
		else:
			velocity.y += get_gravity * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
		if is_on_floor(): #for one way plataform
			position.y += 1
	
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
