extends "res://Libraries/polygon2d-fracture/CuttableObject.gd"


var held = false


signal grabbed(object)

func _ready():

	pass 

func _process(delta):
	pass

func _physics_process(delta):
	if held:
		var movement = (get_global_mouse_position() - position).normalized() * 100
		linear_velocity += movement * delta
		

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			if event.pressed:
				held = true
			else:
				held = false
