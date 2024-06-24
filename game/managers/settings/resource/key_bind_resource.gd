class_name KeybindResource  extends Resource

const MOVE_LEFT: String = "MoveLeft"
const MOVE_RIGHT: String = "MoveRight"
const MOVE_UP: String = "MoveUp"
const MOVE_DOWN: String = "MoveDown"
const JUMP: String = "Jump"
const DASH: String = "Dash"
const PAUSE: String = "Pause"

@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_JUMP_KEY = InputEventKey.new()
@export var DEFAULT_DASH_KEY = InputEventKey.new()
@export var DEFAULT_PAUSE_KEY = InputEventKey.new()

var move_left_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var jump_key = InputEventKey.new()
var dash_key = InputEventKey.new()
var pause_key = InputEventKey.new()
