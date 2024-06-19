extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var dissapearTimer = $DissapearTimer
@onready var appearTimer = $AppearTimer

var time = 1

func _ready():
	set_process(false)

func _process(delta):
	time += 1
	sprite_2d.position += Vector2(0, sin(time) * 2)

func _on_area_2d_body_entered(body):
	if body is Player:
		set_process(true)
		dissapearTimer.start(0.7)

func _on_timer_timeout():
	self.set_collision_layer_value(7, false)
	sprite_2d.visible = false
	appearTimer.start(5)

func _on_appear_timer_timeout():
	self.set_collision_layer_value(7, true)
	sprite_2d.visible = true
	set_process(false)
