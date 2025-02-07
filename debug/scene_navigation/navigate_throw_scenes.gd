extends Node

const QUIZZES_SCENES_NAMES = [
	"ClimaticChangeQuiz1",
	"ForestQuiz1",
	"CityQuiz1",
	"EcologicCityQuiz1"
]

const LEVELS_SCENES_NAMES = [
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

var new_scene: PackedScene

@onready var level_container = $"../Game/LevelContainer"

func _process(_delta: float):
	if OS.is_debug_build() and level_container.get_child_count() != 0:
		if Input.is_action_just_pressed("Navigate"):
			var currScene = level_container.get_child(0)
			if QUIZZES_SCENES_NAMES.has(currScene.name):
				var child_node = currScene.get_child(0)
				new_scene = child_node.next_scene
			
			elif LEVELS_SCENES_NAMES.has(currScene.name):
				var child_node = currScene.find_child("0").find_child("NextLevel")
				new_scene = child_node.new_scene
			
			if new_scene:
				level_container.next_level(new_scene)
			else:
				print("Next scene is null!")
