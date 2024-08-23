extends "state.gd"

@export var dash_direction = Vector2.ZERO

@onready var DashDuration_timer = $DashDuration
@onready var ghost_timer = $GhostTimer
@onready var particles = $GPUParticles2D

var ghost_scene = preload("res://entities/player/effects/DashGhost.tscn")

var dashing = false

func enter_state():
	emit_particles()
	
	Player.can_dash = false
	dashing = true
	DashDuration_timer.start(Player.movement.dash_duration)
	if Player.movement_input != Vector2.ZERO:
		dash_direction = Player.movement_input
	else:
		dash_direction = Player.last_direction
	
	handle_dash_velocity_on_different_directions()
	start_ghost()

func update(delta):
	if Player.dead:
		return STATES.DIE
	
	if Player.bounce:
		return STATES.BOUNCE
	
	if !dashing:
		return STATES.FALL
	return null

func exit_state():
	stop_ghost()
	particles.emitting = false
	dashing = false

func handle_dash_velocity_on_different_directions():
	if Player.movement_input in [Vector2(1, 0), Vector2(-1, 0)]:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_x
	elif Player.movement_input in [Vector2(0, 1), Vector2(0, -1)]:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_y
	else:
		Player.velocity = dash_direction.normalized() * Player.movement.dash_speed_diagonal

func instance_ghost():
	var ghost = ghost_scene.instantiate()
	
	var frameIndex: int = Player.animated_sprite.get_frame()
	var animationName: String = Player.animated_sprite.animation
	var spriteFrames: SpriteFrames = Player.animated_sprite.get_sprite_frames()
	var currentTexture: Texture2D = spriteFrames.get_frame_texture(animationName, frameIndex)
	
	ghost.texture = currentTexture
	ghost.global_position = self.global_position
	ghost.flip_h = Player.animated_sprite.flip_h
	
	Player.get_parent().add_child(ghost)

func start_ghost():
	instance_ghost()
	ghost_timer.start()
	Player.animated_sprite.material.set_shader_parameter("mix_weight", 0.7)
	Player.animated_sprite.material.set_shader_parameter("whiten", true)

func stop_ghost():
	ghost_timer.stop()
	Player.animated_sprite.material.set_shader_parameter("whiten", false)

func emit_particles():
	particles.emitting = true
	particles.process_material.direction = Vector3(-Player.movement_input.x,-Player.movement_input.y,0)

func _on_dash_duration_timeout():
	dashing = false

func _on_ghost_timer_timeout():
	instance_ghost()
