extends "state.gd"

func enter_state():
	# começa um timer para
	# musica e particula de morte
	# quando o timer termina enviar para o estado de rebirth
	Player.position = Player.respawn_position
	Player.dead = false
	Player.velocity = Vector2(0,0)

func update(delta):
	# colocar particulas, uma animação de morte (talvez)
	return STATES.IDLE
