extends AudioStreamPlayer

var musics = {
	"main_menu": "res://assets/audios/musics/menu_music.mp3",
	
	"forest": "res://assets/audios/musics/forest_music.mp3",
	"last_level_forest": "res://assets/audios/musics/last_forest_level_music.mp3",
	
	"city": "res://assets/audios/musics/city_music.mp3",
	"last_level_city": "res://assets/audios/musics/last_level_city_music.mp3",
	
	"intelligent_city": "res://assets/audios/musics/intelligent_city_music.mp3",
}

@onready var ui_container: UIContainer = $"../UIContainer"
@onready var level_container = $"../LevelContainer"

var current_music: String = ""

func play_music(music_name: String):
	if music_name != "" and current_music != music_name:
		current_music = music_name
		print(music_name)
		self.stream = load(musics[music_name])
		self.play()

func _on_finished() -> void:
	self.stream_paused = false
	self.play()

func check_type_of_level(new_scene_instance):
	var level_name = new_scene_instance.name
	if level_name.begins_with("Level") and level_name.contains("Forest"):
		if level_name.contains("6"):
			self.volume_db = -7
			return "last_level_forest"
		else:
			self.volume_db = 0
			return "forest"
	elif level_name.begins_with("Level") and level_name.contains("IntelligentCity"):
		self.volume_db = -10
		return "intelligent_city"
	elif level_name.begins_with("Level") and level_name.contains("City") and !level_name.contains("Intelligent"):
		if level_name.contains("5"):
			self.volume_db = -5
			return "last_level_city"
		else:
			self.volume_db = -5
			return "city"
	return ""
