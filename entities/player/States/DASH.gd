extends "state.gd"

@export var dash_direction = Vector2.ZERO

var dashing = false

@onready var DashDuration_timer = $DashDuration

func enter_state():
	Player.can_dash = false
	dashing = true
	DashDuration_timer.start(Player.movement.dash_duration)
	if Player.movement_input != Vector2.ZERO:
		dash_direction = Player.movement_input
	else:
		dash_direction = Player.last_direction
	
	handle_dash_velocity_on_different_directions()

func update(delta):
	if !dashing:
		return STATES.FALL
	return null

func exit_state():
	dashing = false

func handle_dash_velocity_on_different_directions():
	if Player.movement_input in [Vector2(1, 0), Vector2(-1, 0)]:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_x
	elif Player.movement_input in [Vector2(0, 1), Vector2(0, -1)]:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_y
	else:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_diagonal

func _on_dash_duration_timeout():
	dashing = false
