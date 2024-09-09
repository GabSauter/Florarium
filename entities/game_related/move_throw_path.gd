extends Path2D

@onready var path_follow_2d = $PathFollow2D
@export var speed = 1000

func _ready():
	path_follow_2d.progress_ratio = 0

func _process(delta):
	if path_follow_2d.progress_ratio <= 0.99:
		path_follow_2d.progress += speed * delta 

func reset_position():
	path_follow_2d.progress_ratio = 0
