extends TextEdit


var t = 20.0

func _process(delta):

	if t > 0:
		t -= delta
	else:
		visible = false
