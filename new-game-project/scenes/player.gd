extends CharacterBody2D
var ant_count = 0

func _physics_process(delta):
	var input_direction = Input.get_vector('ui_left','ui_right','ui_up','ui_down')
	velocity=input_direction*400
	move_and_slide()


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group('Ants') and not $HeldAnt.visible:
		area.queue_free()
		$HeldAnt.visible = true
	if area.is_in_group('Basket') and $HeldAnt.visible:
		$HeldAnt.visible=false
		ant_count+=1
		$CanvasLayer/AntCountDisplay.text='ants:'+str(ant_count)
