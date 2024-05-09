extends CharacterBody2D
 
@export var SPEED : int = 350

@export var JUMP_HEIGHT : float = 205
@export var JUMP_TIME_TO_PEAK : float = 0.6
@export var JUMP_TIME_TO_DESCENT : float = 0.5

@onready var JUMP_VELOCITY : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1.0
@onready var JUMP_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1.0
@onready var FALL_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1.0

@export var CUT_JUMP_HEIGHT : float = 0.6

enum State {
	IDLE,
	RUNNING,
	JUMPING,
	FALLING
}

var current_state = State.IDLE
 
func _physics_process(delta):
	var direction = Input.get_axis("move_left","move_right")
	handle_state(direction)
	apply_gravity(delta)
	
	move_and_slide()

func handle_state(direction):
	match current_state:
		State.IDLE:
			idle()
			if direction:
				current_state = State.RUNNING
			if Input.is_action_just_pressed("jump"):
				current_state = State.JUMPING
		State.RUNNING:
			run(direction)
			if not direction:
				current_state = State.IDLE
			if Input.is_action_just_pressed("jump"):
				current_state = State.JUMPING
			if velocity.y > 0:
				current_state = State.FALLING
		State.JUMPING:
			jump(direction)
			if velocity.y > 0:
				current_state = State.FALLING
		State.FALLING:
			fall(direction)
			if is_on_floor() and direction:
				current_state = State.RUNNING
			if is_on_floor():
				current_state = State.IDLE
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true

func idle():
	$AnimatedSprite2D.play("idle")
	velocity.x = 0

func run(direction):
	$AnimatedSprite2D.play("run")
	velocity.x = SPEED * direction

func jump(direction):
	# vertical
	if is_on_floor() and Input.is_action_pressed("jump"):
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump"):
		if velocity.y < 0:
			velocity.y *= CUT_JUMP_HEIGHT
	
	# horizontal
	if direction:
		velocity.x = SPEED * direction

func fall(direction):
	$AnimatedSprite2D.play("fall")
	
	# horizontal
	if direction:
		velocity.x = SPEED * direction

func apply_gravity(delta):
	if not is_on_floor():
		var get_gravity = JUMP_GRAVITY if velocity.y < 0.0 else FALL_GRAVITY
		velocity.y += get_gravity * delta
