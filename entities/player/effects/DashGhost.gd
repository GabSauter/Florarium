extends Sprite2D

func _ready():
	var tween:Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART) 
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"modulate:a",0.0,0.5)
	tween.finished.connect(self._on_tween_finished)

func _on_tween_finished():
	queue_free()
