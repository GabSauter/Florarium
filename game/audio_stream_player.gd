extends AudioStreamPlayer2D

# Mapping level keywords to music file paths
var music_map = {
	"forest": "res://assets/audios/musics/forestmusic.mp3",
	"city": "res://assets/audios/musics/citymusic.mp3",
	"intelligent_city": "res://assets/audios/musics/intelligentcitymusic.mp3",
}

@onready var level_container = $"../LevelContainer"
var current_music_path: String = ""  # Keeps track of the current music

func play_music_for_level():
	# Get the active level node
	var active_level = level_container.new_scene_instance
	if not active_level:
		print("No active level found in LevelContainer!")
		return

	var level_name = active_level.name
	print(level_name)
	var new_music_path = ""

	# Determine the appropriate music path based on the level name
	if level_name.begins_with("Level") and level_name.contains("Forest"):
		new_music_path = music_map["forest"]
		self.volume_db = 1
	elif level_name.begins_with("Level") and level_name.contains("IntelligentCity"):
		new_music_path = music_map["intelligent_city"]
		self.volume_db = -5
	elif level_name.begins_with("Level") and level_name.contains("City") and !level_name.contains("Intelligent"):
		new_music_path = music_map["city"]
		self.volume_db = -3

	# Only switch music if it's different from the current music
	print(new_music_path)
	print(current_music_path)
	if new_music_path != "" and new_music_path != current_music_path:
		current_music_path = new_music_path
		self.stream = load(new_music_path)
		self.play()
		print("Playing new music:", new_music_path)
	else:
		print("Music remains unchanged or no matching music found.")
