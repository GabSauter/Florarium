extends Node

@onready var player: Player = $"../.."

@onready var IDLE = $IDLE
@onready var MOVE = $MOVE
@onready var JUMP = $JUMP
@onready var FALL = $FALL
@onready var DASH = $DASH
@onready var SLIDE = $SLIDE
@onready var WALL_JUMP = $WALL_JUMP
@onready var BOUNCE = $BOUNCE
@onready var DIE = $DIE

var current_state = null
var prev_state = null

func _ready():
	for state in self.get_children():
		state.STATES = self
		state.player = player
	prev_state = IDLE
	current_state = IDLE

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()
