extends Node

var STATES = null
var player: Player = null

func enter_state():
	pass

func exit_state():
	pass

func update(delta):
	return null

func player_movement(delta):
	if player.movement_input.x == 0 and player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement.FRICTION * delta)
	else:
		if (player.movement_input.x > 0 && player.velocity.x < 0) or (player.movement_input.x < 0 && player.velocity.x > 0):
			decelerate_when_turn(120 * player.movement_input.x)
		else:
			player.velocity.x = move_toward(player.velocity.x, player.movement.MAX_SPEED * player.movement_input.x, player.movement.ACCELERATION * delta)
	if player.movement_input.x > 0:
		player.last_direction = Vector2.RIGHT
	elif player.movement_input.x < 0:
		player.last_direction = Vector2.LEFT

func decelerate_when_turn(amount):
	if player.current_state != STATES.WALL_JUMP:
		player.velocity.x += amount
