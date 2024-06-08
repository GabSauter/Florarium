extends "state.gd"

func enter_state():
	Player.position = Player.respawn_position
	Player.dead = false
	Player.velocity = Vector2(0,0)

func update(delta):
	# colocar particulas, uma animação de morte (talvez)
	return STATES.IDLE
