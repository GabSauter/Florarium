extends "state.gd"

func enter_state():
	# começa um timer para
	# musica e particula de morte
	# quando o timer termina enviar para o estado de rebirth
	player.position = player.respawn_position
	player.dead = false
	player.velocity = Vector2(0,0)

func update(delta):
	# colocar particulas, uma animação de morte (talvez)
	return STATES.IDLE
