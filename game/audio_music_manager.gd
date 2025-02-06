extends AudioStreamPlayer

var musics = {
	"main_menu": {
		"location": "res://assets/audios/musics/menu_music.mp3",
		"volume": -10
	},
	
	"forest": {
		"location": "res://assets/audios/musics/forest_music.mp3",
		"volume": -4
	},
	
	"last_level_forest": {
		"location": "res://assets/audios/musics/last_forest_level_music.mp3",
		"volume": -22
	},
	
	"city": {
		"location": "res://assets/audios/musics/city_music.mp3",
		"volume": -15
	},
	
	"last_level_city": {
		"location":"res://assets/audios/musics/last_level_city_music.mp3",
		"volume": -18
	},
	
	"intelligent_city": {
		"location":"res://assets/audios/musics/intelligent_city_music.mp3",
		"volume": -28
	},
}

@onready var ui_container: UIContainer = $"../UIContainer"
@onready var level_container = $"../LevelContainer"

var current_music: String = ""

func play_music(music_name: String):
	print(music_name)
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
