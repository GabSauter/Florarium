extends Control

var runningScene: RunningScene
@export var next_scene: PackedScene

@onready var v_box_container_options = $Background/CardBackground/VBoxContainer/VBoxContainerOptions
@onready var question_text = $Background/CardBackground/VBoxContainer/QuestionText
@onready var next_question_button = $Background/CardBackground/NextQuestionButton
@onready var label_explanation = $Background/CardBackground/VBoxContainer/LabelExplanation
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
	runningScene = get_tree().current_scene.get_node("RunningScene")
	
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
	if current_quiz.correct == button.text:
		button.modulate = color_right
		numberOfCorrect += 1
		audio_correct.play()
		next_question_button.disabled = false
	else:
		button.modulate = color_wrong
		audio_wrong.play()
	
	label_explanation.visible = true

func next_question():
	for button in buttons:
		button.pressed.disconnect(_button_pressed)
		button.modulate = Color.WHITE
	
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
	runningScene.next_scene(next_scene)
