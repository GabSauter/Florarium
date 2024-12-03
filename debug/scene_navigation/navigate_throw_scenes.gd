extends Node

var new_scene: PackedScene

var level_container: LevelContainer

var quizzes_scenes = [
	"ClimaticChangeQuiz1",
	"ForestQuiz1",
	"CityQuiz1",
	"EcologicCityQuiz1"
]

var levels_scenes = [
	"Level1Forest",
	"Level2Forest",
	"Level3Forest",
	"Level4Forest",
	"Level5Forest",
	"Level6Forest",
	"Level1City",
	"Level2City",
	"Level3City",
	"Level4City",
	"Level5City",
	"Level1IntelligentCity",
	"Level2IntelligentCity",
	"Level3IntelligentCity",
	"Level4IntelligentCity",
	"Level5IntelligentCity"
];

func _ready():
	level_container = get_tree().current_scene.get_node("LevelContainer")

func _process(delta: float) -> void:
	if OS.is_debug_build():
		if Input.is_action_just_pressed("Navigate"):
			var currScene = level_container.get_child(0)
			if quizzes_scenes.has(currScene.name):
				var child_node = currScene.get_child(0)
				new_scene = child_node.next_scene
			
			elif levels_scenes.has(currScene.name):
				var child_node = currScene.find_child("0").find_child("NextLevel")
				new_scene = child_node.new_scene
			
			if new_scene:
				level_container.next_level(new_scene)
			else:
				print("Next scene is null!")
