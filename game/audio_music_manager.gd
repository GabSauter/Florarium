extends AudioStreamPlayer2D

var musics = {
	"main_menu": "res://assets/audios/musics/menu_music.mp3",
	
	"forest": "res://assets/audios/musics/forest_music.mp3",
	"city": "res://assets/audios/musics/city_music.mp3",
	"intelligent_city": "res://assets/audios/musics/intelligent_city_music.mp3",
}

@onready var ui_container = $"../UIContainer"
@onready var level_container = $"../LevelContainer"
var current_music_path: String = ""

func play_music():
	var active_level = level_container.new_scene_instance
	var level_name = ""
	if active_level:
		level_name = active_level.name
	
	var new_music_path = ""
	
	if ui_container.find_child("MainMenu"):
		new_music_path = musics["main_menu"]
		self.volume_db = -5
	if level_name.begins_with("Level") and level_name.contains("Forest"):
		new_music_path = musics["forest"]
		self.volume_db = 0
	elif level_name.begins_with("Level") and level_name.contains("IntelligentCity"):
		new_music_path = musics["intelligent_city"]
		self.volume_db = -10
	elif level_name.begins_with("Level") and level_name.contains("City") and !level_name.contains("Intelligent"):
		new_music_path = musics["city"]
		self.volume_db = -5
	
	if new_music_path != "" and new_music_path != current_music_path:
		current_music_path = new_music_path
		self.stream = load(new_music_path)
		self.play()

func _on_finished() -> void:
	self.stream_paused = false
	self.play()
