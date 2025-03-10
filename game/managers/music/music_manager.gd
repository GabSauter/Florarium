extends AudioStreamPlayer

var musics = load("res://game/managers/music/musics_constants.gd").MUSICS

@onready var ui_container: UIContainer = $"../UIContainer"
@onready var level_container = $"../LevelContainer"

var current_music: String = ""

func play_music(music_name: String):
	if music_name != "" and current_music != music_name:
		current_music = music_name
		self.volume_db = musics[music_name].volume
		self.stream = load(musics[music_name].location)
		self.play()

func _on_finished() -> void:
	self.stream_paused = false
	self.play()

func check_type_of_level(new_scene_instance):
	var level_name = new_scene_instance.name
	if level_name.begins_with("Level"):
		if  level_name.contains("Forest"):
			if level_name.contains("6"):
				return "last_level_forest"
			else:
				return "forest"
		elif level_name.contains("IntelligentCity"):
			return "intelligent_city"
		elif level_name.contains("City") and !level_name.contains("Intelligent"):
			if level_name.contains("5"):
				return "last_level_city"
			else:
				return "city"
	return ""
