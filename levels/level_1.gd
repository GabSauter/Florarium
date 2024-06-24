extends Node2D

@onready var player: Player = $"0/Player"

var player_respawn_position = Vector2(10699,-770)

func _ready():
	player.respawn_position = player_respawn_position
