extends Area2D

# com o is active, faz com que o respawn seja no último checkpoint pego
# desabilitando os checkpoints anteriores, sendo viável para jogos tipo celeste, mas inviável para jogos tipo hollow knight
var isActive = false

func _on_body_entered(body):
	if body is Player and !isActive:
		body.respawn_position = global_position
		isActive = true
