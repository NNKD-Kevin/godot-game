class_name Player 
extends CharacterBody2D

var dragging=false
var mouse_on=false
@export var power:=20.0
@export var max_drag:=200.0
@export var min_drag := 10.0     
@export var friction := 600.0
@export var bounciness := 0.8
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_mouse_entered()->void:
	mouse_on=true
func _on_mouse_exited() -> void:
	mouse_on=false
func _input(event):
	if Input.is_action_just_pressed("drag") and mouse_on==true:
		dragging=true
	if Input.is_action_just_released('drag') and dragging:
		dragging=false
		var pull = global_position-get_global_mouse_position()
		if pull.length()>min_drag:
			velocity=pull.limit_length(max_drag)*power
func _process(delta: float) -> void:
	$handle.visible=dragging
	if dragging:
		var offset := (get_global_mouse_position() - global_position).limit_length(max_drag)
		$handle.global_position = global_position + offset
func _physics_process(delta: float) -> void:
	var collision:=move_and_collide(velocity*delta)
	if collision:
		velocity=velocity.bounce(collision.get_normal())*bounciness
	velocity = velocity.move_toward(Vector2.ZERO,friction*delta)
	if velocity.length()>5:
		animated_sprite_2d.play('roll')
	else:
		animated_sprite_2d.play('default')
	var direction := Input.get_axis("move_left", "move_right")
	if velocity[0] < 0:
		animated_sprite_2d.flip_h = false
	if velocity[1] > 0:
		animated_sprite_2d.flip_h = true
	

	
		
		


func _on_slime_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
