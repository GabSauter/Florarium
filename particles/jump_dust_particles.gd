extends GPUParticles2D

func _ready():
	one_shot = true
	emitting = true
	var time = (lifetime * 2) / speed_scale
	var timer = get_tree().create_timer(time)
	timer.timeout.connect(self.queue_free)
