extends Control

var level_container: LevelContainer
@export var next_scene: PackedScene

@onready var v_box_container_options = $Background/CardBackground/VBoxContainer2/VBoxContainer/VBoxContainerOptions
@onready var question_text = $Background/CardBackground/VBoxContainer2/VBoxContainer/QuestionText
@onready var next_question_button = $Background/CardBackground/NextQuestionButton
@onready var label_explanation = $Background/CardBackground/VBoxContainer2/VBoxContainer/LabelExplanation
@onready var audio_wrong = $Background/CardBackground/AudioWrong
@onready var audio_correct = $Background/CardBackground/AudioCorrect

@onready var quiz_over = $Background/QuizOver
@onready var score = $Background/QuizOver/BackGround/VBoxContainer/Score

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int
var numberOfCorrect: int
var current_quiz: QuizQuestion:
	get: return quiz.theme[index]

func _ready():
	level_container = get_tree().current_scene.get_node("LevelContainer")
	
	numberOfCorrect = 0
	for button in v_box_container_options.get_children():
		buttons.append(button)
	
	load_quiz()

func load_quiz():
	label_explanation.visible = false
	next_question_button.disabled = true
	
	question_text.text = current_quiz.question
	label_explanation.text = current_quiz.explanation
	
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_button_pressed.bind(buttons[i]))

func _button_pressed(button: Button):
	var stylebox = StyleBoxFlat.new()
	if current_quiz.correct == button.text:
		button.modulate = color_right
		stylebox.bg_color = Color("#FFF")
		button.add_theme_stylebox_override("normal", stylebox)
		numberOfCorrect += 1
		audio_correct.play()
		next_question_button.disabled = false
	else:
		button.modulate = color_wrong
		stylebox.bg_color = Color("#FFF")
		button.add_theme_stylebox_override("normal", stylebox)
		audio_wrong.play()
	
	label_explanation.visible = true

func next_question():
	for button in buttons:
		button.pressed.disconnect(_button_pressed)
		button.modulate = Color.WHITE
		var stylebox = StyleBoxEmpty.new()
		button.add_theme_stylebox_override("normal", stylebox)
	
	load_quiz()

func _on_next_question_button_button_down():
	index += 1
	if index >= quiz.theme.size():
		end_quiz()
	else:
		if index == quiz.theme.size() - 1:
			next_question_button.text = "Ver Resultados"
		next_question()

func end_quiz():
	quiz_over.show()
	$Background/CardBackground.visible = false
	score.text = str(numberOfCorrect) + "/" + str(quiz.theme.size())

func _on_continue_button_button_down():
	level_container.next_level(next_scene)
	self.queue_free()
