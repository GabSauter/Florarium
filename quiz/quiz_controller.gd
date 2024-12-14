extends Control

var level_container: LevelContainer
@export var next_scene: PackedScene

@onready var card_background = $Background/CardBackground
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
var number_of_questions: int
var number_of_correct_answers: int
var current_quiz: QuizQuestion:
	get: return quiz.theme[index]
var numbers_of_guesses: int
var questions_already_responded: Array[String] = []

func _ready():
	numbers_of_guesses = 0
	number_of_correct_answers = 0
	
	for button in v_box_container_options.get_children():
		buttons.append(button)
	
	load_quiz()

func load_quiz():
	label_explanation.visible = false
	next_question_button.disabled = true
	
	question_text.text = current_quiz.question
	label_explanation.text = current_quiz.explanation
	
	var options = current_quiz.options
	options.shuffle()
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_button_pressed.bind(buttons[i]))

func _button_pressed(button: Button):
	var is_user_correct = current_quiz.correct == button.text
	if is_user_correct:
		answer_correct(button)
	else:
		answer_wrong(button)
	
	numbers_of_guesses = numbers_of_guesses + 1
	label_explanation.visible = true

func answer_correct(button):
	button.modulate = color_right
	audio_correct.play()
	next_question_button.disabled = false
	
	if questions_already_responded.find(current_quiz.question) == -1:
		if numbers_of_guesses == 0:
			number_of_correct_answers += 1
		questions_already_responded.append(current_quiz.question)

func answer_wrong(button):
	button.modulate = color_wrong
	audio_wrong.play()
	if numbers_of_guesses == 0:
		append_the_question_in_last_position()

func append_the_question_in_last_position():
	quiz.theme.append(current_quiz)

func _on_next_question_button_button_down():
	index += 1
	if index >= quiz.theme.size():
		end_quiz()
	else:
		if index == quiz.theme.size() - 1:
			next_question_button.text = "Próximo"
		next_question()

func next_question():
	for button in buttons:
		button.pressed.disconnect(_button_pressed)
		button.modulate = Color.WHITE
	numbers_of_guesses = 0
	load_quiz()

func end_quiz():
	quiz_over.show()
	card_background.visible = false
	score.text = str(number_of_correct_answers) + "/" + str(questions_already_responded.size())
	save_quiz()

func _on_continue_button_button_down():
	level_container = get_tree().current_scene.get_node("LevelContainer")
	level_container.next_level(next_scene)

func save_quiz():
	const QUIZ_SAVE_PATH: String = "user://QuizzesData.save"
	var quiz_data = {}
	var file: FileAccess
	if FileAccess.file_exists(QUIZ_SAVE_PATH):
		file = FileAccess.open(QUIZ_SAVE_PATH, FileAccess.READ)
		var existing_data = file.get_as_text()
		file.close()
		if existing_data != "":
			var json = JSON.new()
			json.parse(existing_data)
			quiz_data = json.data

	quiz_data[quiz.name] = {
		"number_of_correct": number_of_correct_answers,
		"number_of_questions": questions_already_responded.size()
	}

	file = FileAccess.open(QUIZ_SAVE_PATH, FileAccess.WRITE)
	var json_data_string = JSON.stringify(quiz_data, "\t")
	file.store_string(json_data_string)
	file.close()

	print("Quiz data saved:", json_data_string)
