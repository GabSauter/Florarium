extends "state.gd"

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var game_music: AudioStreamPlayer = get_node("/root/Game/AudioMusicManager")
var game_music_volume: float

func enter_state():
	audio_stream_player_2d.play()
	player.dead = true
	timer.start(0.05)
	game_music_volume = game_music.volume_db

func update(_delta):
	player.velocity = Vector2(0,0)
	if player.dead:
		#game_music.volume_db = lerp(game_music.volume_db, -30.0, 0.8 * delta)
		#player.animated_sprite.material.set_shader_parameter("mix_weight", 1)
		#player.animated_sprite.material.set_shader_parameter("whiten", true)
		pass
	else:
		return STATES.IDLE

func _on_timer_timeout() -> void:
	player.position = player.respawn_position
	player.dead = false
	#game_music.volume_db = game_music_volume
	#player.animated_sprite.material.set_shader_parameter("mix_weight", 0.7)
	#player.animated_sprite.material.set_shader_parameter("whiten", false)
