extends Node

@onready var moviment_text: RichTextLabel = $MovimentText
@onready var jump_text: RichTextLabel = $JumpText
@onready var hold_jump_text: RichTextLabel = $HoldJumpText
@onready var respawn_text: RichTextLabel = $RespawnText
@onready var spikes_text: RichTextLabel = $SpikesText
@onready var wall_jump_text: RichTextLabel = $WallJumpText
@onready var dash_text: RichTextLabel = $DashText
@onready var dash_collectable_text: RichTextLabel = $DashCollectableText

@onready var KEYBIND_DEFAULT: KeybindResource = preload("res://game/managers/settings/resource/keybind_default_resource.tres")

func _ready() -> void:
	moviment_text.text = "[center][wave]Aperte " + KEYBIND_DEFAULT.move_left_key.as_text_physical_keycode() + " para ir para esquerda\nAperte " + KEYBIND_DEFAULT.move_right_key.as_text_physical_keycode() + " para ir para direita"
	jump_text.text = "[center][wave]Aperte " + KEYBIND_DEFAULT.jump_key.as_text_physical_keycode() + " para pular"
	hold_jump_text.text = "[center][wave]Segure " + KEYBIND_DEFAULT.jump_key.as_text_physical_keycode() + " para pular mais alto"
	respawn_text.text = "[center][wave]Esse é um checkpoint caso você perca\nirá voltar para o último checkpoint"
	spikes_text.text = "[center][wave]Evite os espinhos para não perder"
	wall_jump_text.text = "[center][wave]Aperte " + KEYBIND_DEFAULT.jump_key.as_text_physical_keycode() + " quando estiver em uma parede\npara realizar o pulo na parede"
	dash_text.text = "[center][wave]Aperte " + KEYBIND_DEFAULT.dash_key.as_text_physical_keycode() + " para realizar um dash\nQuando você encosta no chão você ganha um dash para usar\nTente pular e dar um dash para cima"
	dash_collectable_text.text = "[center][wave]Colete o item de dash para habilitar a habilidade de dash\ne poder dashar sem precisar enconstar no chão"
