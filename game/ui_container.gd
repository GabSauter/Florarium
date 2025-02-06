class_name UIContainer extends CanvasLayer

@onready var audio_music_manager: AudioStreamPlayer = $"../MusicManager"

func next_ui(next_ui_scene: PackedScene):
	if self.get_child_count() > 0:
		var current_scene = self.get_child(0)
		current_scene.queue_free()

	var new_scene_instance = next_ui_scene.instantiate()
	self.add_child(new_scene_instance)
	if new_scene_instance.name == "MainMenu":
		new_scene_instance.new_game_scene = load("res://quiz/climatic_change_especific/climatic_change_quiz_1.tscn")
		audio_music_manager.play_music("main_menu")
