extends AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		play()
	else:
		stop()
