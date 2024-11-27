extends AudioStreamPlayer2D

var music_map = {
	"forest": "res://assets/audios/musics/forestmusic.mp3",
	"city": "res://assets/audios/musics/citymusic.mp3",
	"intelligent_city": "res://assets/audios/musics/intelligentcitymusic.mp3",
}

@onready var level_container = $"../LevelContainer"
var current_music_path: String = ""

func play_music_for_level():
	var active_level = level_container.new_scene_instance
	if not active_level:
		return

	var level_name = active_level.name
	var new_music_path = ""

	if level_name.begins_with("Level") and level_name.contains("Forest"):
		new_music_path = music_map["forest"]
		self.volume_db = 0
	elif level_name.begins_with("Level") and level_name.contains("IntelligentCity"):
		new_music_path = music_map["intelligent_city"]
		self.volume_db = -10
	elif level_name.begins_with("Level") and level_name.contains("City") and !level_name.contains("Intelligent"):
		new_music_path = music_map["city"]
		self.volume_db = -5
	
	if new_music_path != "" and new_music_path != current_music_path:
		current_music_path = new_music_path
		self.stream = load(new_music_path)
		self.play()

func _on_finished() -> void:
	self.stream_paused = false
	self.play()
