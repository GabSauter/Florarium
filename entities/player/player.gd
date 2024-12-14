class_name Player
extends CharacterBody2D

@onready var STATES: Node2D = $Behaviour/STATES
@onready var input_handler: InputHandler = $InputHandler
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@export var movement: PlayerMovementData

#mechanics
var can_dash = true

#buffer
var jump_buffer = false

var dead = false
var respawn_position: Vector2

var bounce = false
var bounce_rotation
var bounce_force

func _physics_process(delta):
	input_handler.player_input()
	STATES.change_state(STATES.current_state.update(delta))
	move_and_slide()
