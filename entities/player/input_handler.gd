class_name InputHandler
extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite"
@onready var player: Player = $".."

var last_direction = Vector2.RIGHT
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var cut_jump_input = false
var dash_input = false

func player_input():
	if player.dead:
		return
	
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
	if player.is_on_floor():
		position.y += 1
