extends CanvasLayer

@onready var ui_container = get_tree().current_scene.get_node("UIContainer")
@onready var level_container = get_tree().current_scene.get_node("LevelContainer")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		go_to_main_menu()

func go_to_main_menu():
	audio_stream_player.play()
	var main_menu = load("res://ui/menu/main_menu/main_menu.tscn")
	await ui_container.next_ui(main_menu)
	# save game
	clear_level_container()

func clear_level_container():
	var children = level_container.get_children()
	for child in children:
		level_container.remove_child(child)
		child.queue_free()
