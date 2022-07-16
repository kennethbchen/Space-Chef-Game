extends "res://Libraries/polygon2d-fracture/CuttableObject.gd"

class_name BaseObject

var local_grab_position = Vector2.ZERO

var held = false

func _ready():

	pass 
	
func _physics_process(delta):
	if held:
		var movement = (get_global_mouse_position() - position - local_grab_position).normalized() * 800
		linear_velocity += movement * delta
		
		#var rotation_error = (position.angle_to_point(get_global_mouse_position())) - position.angle_to_point(position + local_grab_position)
		
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("grab"):
		
		local_grab_position = get_global_mouse_position() - position
		
		held = true

func _on_grab_stop():
	held = false
