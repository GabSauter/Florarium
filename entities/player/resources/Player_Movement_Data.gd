extends Resource
class_name PlayerMovementData

#player_movement
	#run
@export var ACCELERATION = 1050
@export var MAX_SPEED : int = 650
@export var FRICTION = 3000
	#jump
@export var JUMP_HEIGHT : float = 423
@export var JUMP_TIME_TO_PEAK : float = 0.6
@export var JUMP_TIME_TO_DESCENT : float = 0.5
@export var JUMP_TIME_TO_DESCENT_SLIDING : float = 1
@export var CUT_JUMP_HEIGHT: float = 0.6
@export var MAX_FALL_SPEED: float = 5000

@export var JUMP_OFF_WALL_POWER = 1200

@export var JUMP_VELOCITY : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1.0
@export var JUMP_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1.0
@export var FALL_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1.0
@export var SLIDE_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT_SLIDING * JUMP_TIME_TO_DESCENT_SLIDING)) * -1.0
@export var APEX_GRAVITY : float = 1000
@export var APEX_RANGE : float = 60

@export var dash_speed_x = 1300
@export var dash_speed_y = 1000
@export var dash_speed_diagonal = 1100
@export var dash_duration = .25
