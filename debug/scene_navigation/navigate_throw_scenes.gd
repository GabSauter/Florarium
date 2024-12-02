extends Node

var new_scene: PackedScene

var levelContainer: LevelContainer

var quizzesScenes = [
	"ClimaticChangeQuiz1",
	"ForestQuiz1",
	"CityQuiz1",
	"EcologicCityQuiz1"
]

var levelsScenes = [
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
	levelContainer = get_tree().current_scene.get_node("LevelContainer")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Navigate"):
		var currScene = levelContainer.get_child(0)
		if quizzesScenes.has(currScene.name):
			var child_node = currScene.get_child(0)
			new_scene = child_node.next_scene

		elif levelsScenes.has(currScene.name):
			var child_node = currScene.find_child("0").find_child("NextLevel")
			new_scene = child_node.new_scene

		if new_scene:
			levelContainer.next_level(new_scene)
		else:
			print("Next scene is null!")
