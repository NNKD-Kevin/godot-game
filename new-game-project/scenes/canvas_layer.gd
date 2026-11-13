extends CanvasLayer
func _process(_delta: float) -> void:
	$Label.text = "Points: " + str(Global.slime_killed*5)
