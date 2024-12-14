extends Path2D

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer
@onready var sprite_2d = $AnimatableBody/Sprite2D
@onready var collision_shape_2d = $AnimatableBody/CollisionShape2D
@onready var player: Player = $"../../Player"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


#@export var sprite: Texture2D
#@export var collisionShape: Shape2D
@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0

func _ready():
	audio_stream_player_2d.play()
	#sprite_2d.texture = sprite
	#collision_shape_2d.shape = collisionShape
	
	if not loop:
		animation.play("move")
		animation.speed_scale = speed_scale
		set_process(false)

func _process(delta):
	path.progress += speed * delta
	
	if player.STATES.current_state == player.STATES.DIE:
		path.progress = 0

func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player_2d.play()
