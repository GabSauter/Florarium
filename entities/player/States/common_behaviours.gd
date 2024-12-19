extends Node2D

@onready var player: Player = $"../.."
@onready var states: Node2D = $"../STATES"

# Horizontal Movement
func player_movement(delta):
	if player.input_handler.movement_input.x == 0 and player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement.FRICTION * delta)
	else:
		if (player.input_handler.movement_input.x > 0 && player.velocity.x < 0) or (player.input_handler.movement_input.x < 0 && player.velocity.x > 0):
			decelerate_when_turn(player.input_handler.movement_input.x * 8500, delta)
		else:
			player.velocity.x = move_toward(player.velocity.x, player.movement.MAX_SPEED * player.input_handler.movement_input.x, player.movement.ACCELERATION * delta)
	
	set_player_last_direction()

func set_player_last_direction():
	if player.input_handler.movement_input.x > 0:
		player.input_handler.last_direction = Vector2.RIGHT
	elif player.input_handler.movement_input.x < 0:
		player.input_handler.last_direction = Vector2.LEFT

func decelerate_when_turn(amount, delta):
	if player.STATES.current_state != player.STATES.WALL_JUMP:
		player.velocity.x += amount * delta


# Gravity
func calc_gravity(delta):
	if not player.is_on_floor():
		var gravity: float
		if abs(player.velocity.y) < player.movement.APEX_RANGE:
			gravity = player.movement.APEX_GRAVITY
		elif player.STATES.current_state == player.STATES.FALL:
			gravity = ((-2.0 * player.movement.JUMP_HEIGHT) / (player.movement.JUMP_TIME_TO_DESCENT * player.movement.JUMP_TIME_TO_DESCENT)) * -1.0
		elif player.STATES.current_state == player.STATES.SLIDE and player.velocity.y > 0:
			gravity = ((-2.0 * player.movement.JUMP_HEIGHT) / (player.movement.JUMP_TIME_TO_DESCENT_SLIDING * player.movement.JUMP_TIME_TO_DESCENT_SLIDING)) * -1.0
		else:
			gravity = ((-2.0 * player.movement.JUMP_HEIGHT) / (player.movement.JUMP_TIME_TO_PEAK * player.movement.JUMP_TIME_TO_PEAK)) * -1.0
		
		if player.velocity.y > player.movement.MAX_FALL_SPEED:
			player.velocity.y = player.movement.MAX_FALL_SPEED
		else:
			player.velocity.y += gravity * delta
