extends Node2D

@onready var player: Player = $"../.."
@onready var states: Node2D = $"../STATES"

# Horizontal Movement
func player_movement(delta):
	if player.input_handler.movement_input.x == 0 and player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement.FRICTION * delta)
	else:
		if (player.input_handler.movement_input.x > 0 && player.velocity.x < 0) or (player.input_handler.movement_input.x < 0 && player.velocity.x > 0):
			decelerate_when_turn(player.input_handler.movement_input.x * 2500, delta)
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
			gravity = player.movement.FALL_GRAVITY
		elif player.STATES.current_state == player.STATES.SLIDE and player.velocity.y > 0:
			gravity = player.movement.SLIDE_GRAVITY
		else:
			gravity = player.movement.JUMP_GRAVITY
		
		if player.velocity.y > player.movement.MAX_FALL_SPEED:
			player.velocity.y = player.movement.MAX_FALL_SPEED
		else:
			player.velocity.y += gravity * delta
