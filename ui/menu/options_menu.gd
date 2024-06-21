extends Control

@onready var game = $"../.."

func _on_back_button_button_down():
	self.visible = false
	self.set_process(false)
