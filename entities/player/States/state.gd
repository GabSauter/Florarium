extends Node

var STATES = null
var Player = null

func enter_state():
	pass

func exit_state():
	pass

func update(delta):
	return null

func player_movement(delta):
	# da para colocar diferentes aceleração e fricção quando o personagem está no chão ou no ar
	if Player.movement_input.x == 0:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.FRICTION * delta)
	else:
		if (Player.movement_input.x > 0 && Player.velocity.x < 0) or (Player.movement_input.x < 0 && Player.velocity.x > 0):
			decelerate_when_turn(30 * Player.movement_input.x)
		else:
			Player.velocity.x = move_toward(Player.velocity.x, Player.MAX_SPEED * Player.movement_input.x, Player.ACCELERATION * delta)
	if Player.movement_input.x > 0:
		Player.last_direction = Vector2.RIGHT
	elif Player.movement_input.x < 0:
		Player.last_direction = Vector2.LEFT

func decelerate_when_turn(amount):
	Player.velocity.x += amount
