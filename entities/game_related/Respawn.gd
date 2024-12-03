extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var particles = $GPUParticles2D

# com o is active, faz com que o respawn seja no último checkpoint pego
# desabilitando os checkpoints anteriores, sendo viável para jogos tipo celeste, mas inviável para jogos tipo hollow knight
var isActive = false

func _ready():
	particles.emitting = false

func _on_body_entered(body):
	if body is Player and !isActive:
		body.respawn_position = global_position
		isActive = true
		animated_sprite.play("open_flower")
		particles.emitting = true
