extends "state.gd"

var jump_dust_particles_scene = preload("res://particles/jump_dust_particles.tscn")

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

func enter_state():
	var jump_dust_particles = jump_dust_particles_scene.instantiate()
	jump_dust_particles.position = Player.position
	jump_dust_particles.emitting = true
	Player.get_parent().add_child(jump_dust_particles)
	
	Player.velocity.y = Player.movement.JUMP_VELOCITY

func update(delta):
	Player.animated_sprite.play("jump")
	
	Player.gravity(delta)
	player_movement(delta)
	cut_jump_height()
	start_jump_buffer_timer()
	
	if Player.dead:
		return STATES.DIE
	
	if Player.bounce:
		return STATES.BOUNCE
	
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.is_on_wall_only():
		return STATES.SLIDE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func cut_jump_height():
	if Player.cut_jump_input:
		if Player.velocity.y < 0:
			Player.velocity.y *= Player.movement.CUT_JUMP_HEIGHT

func start_jump_buffer_timer():
	if Player.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if Player.current_state == STATES.IDLE or Player.current_state == STATES.MOVE or Player.current_state == STATES.SLIDE:
		Player.jump_buffer = true
	else:
		Player.jump_buffer = false
