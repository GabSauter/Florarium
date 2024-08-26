extends Resource
class_name PlayerMovementData

#player_movement
	#run
@export var ACCELERATION = 600
@export var MAX_SPEED : int = 450
@export var FRICTION = 2900
	#jump
@export var JUMP_HEIGHT : float = 230
@export var JUMP_TIME_TO_PEAK : float = 0.4
@export var JUMP_TIME_TO_DESCENT : float = .37
@export var JUMP_TIME_TO_DESCENT_SLIDING : float = 2
@export var CUT_JUMP_HEIGHT: float = 0.55
@export var MAX_FALL_SPEED: float = 1300

@export var JUMP_OFF_WALL_POWER = 800

var JUMP_VELOCITY : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1.0
var JUMP_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1.0
var FALL_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1.0
var SLIDE_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT_SLIDING * JUMP_TIME_TO_DESCENT_SLIDING)) * -1.0

@export var APEX_GRAVITY : float = 400
@export var APEX_RANGE : float = 30

@export var dash_speed_x = 800
@export var dash_speed_y = 700
@export var dash_speed_diagonal = 710
@export var dash_duration = .15
