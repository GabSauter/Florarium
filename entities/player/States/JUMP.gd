extends "state.gd"

var jump_dust_particles_scene = preload("res://particles/jump_dust_particles.tscn")

@onready var JumpBufferTimer = $JumpBufferTimer
@export var jump_buffer_duration = .1

func enter_state():
	var jump_dust_particles = jump_dust_particles_scene.instantiate()
	jump_dust_particles.position = player.position
	jump_dust_particles.emitting = true
	player.get_parent().add_child(jump_dust_particles)
	
	player.velocity.y = player.movement.JUMP_VELOCITY

func update(delta):
	player.animated_sprite.play("jump")
	
	player.calc_gravity(delta)
	player_movement(delta)
	cut_jump_height()
	start_jump_buffer_timer()
	
	if player.dead:
		return STATES.DIE
	
	if player.bounce:
		return STATES.BOUNCE
	
	if player.velocity.y > 0:
		return STATES.FALL
	if player.is_on_wall_only():
		return STATES.SLIDE
	if player.dash_input and player.can_dash:
		return STATES.DASH
	return null

func cut_jump_height():
	if player.cut_jump_input:
		if player.velocity.y < 0:
			player.velocity.y *= player.movement.CUT_JUMP_HEIGHT

func start_jump_buffer_timer():
	if player.jump_input_actuation:
		JumpBufferTimer.start(jump_buffer_duration)

func _on_jump_buffer_timer_timeout():
	if player.current_state == STATES.IDLE or player.current_state == STATES.MOVE or player.current_state == STATES.SLIDE:
		player.jump_buffer = true
	else:
		player.jump_buffer = false
