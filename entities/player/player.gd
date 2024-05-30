extends CharacterBody2D

#player input
var movement_input = Vector2.ZERO

var jump_input = false
var jump_input_actuation = false
var cut_jump_input = false

var climb_input = false 
var dash_input = false

#player_movement
	#run
var last_direction = Vector2.RIGHT
@export var ACCELERATION = 1050
@export var MAX_SPEED : int = 650
@export var FRICTION = 3000
	#jump
@export var JUMP_HEIGHT : float = 383
@export var JUMP_TIME_TO_PEAK : float = 0.6
@export var JUMP_TIME_TO_DESCENT : float = 0.5
@export var CUT_JUMP_HEIGHT: float = 0.6

@onready var JUMP_VELOCITY : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1.0
@onready var JUMP_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1.0
@onready var FALL_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1.0

#mechanics
var can_dash = true
var can_air_jump = true

#states
var current_state = null
var prev_state = null

#nodes
@onready var STATES = $STATES
@onready var Raycasts = $Raycasts

func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE

func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())
	move_and_slide()

func gravity(delta):
	if not is_on_floor():
		var get_gravity = JUMP_GRAVITY if velocity.y < 0.0 else FALL_GRAVITY
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
	
	#climb
	if Input.is_action_pressed("Climb"):
		climb_input = true
	else: 
		climb_input = false
	
	#dash
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
	else:
		dash_input = false
