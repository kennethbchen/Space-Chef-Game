extends "res://Libraries/polygon2d-fracture/CuttableObject.gd"

class_name BaseObject

onready var outline = $Outline

var local_grab_position = Vector2.ZERO

var held = false

func _ready():
	
	if _polygon2d.polygon.size() > 0:
		_update_line()
		

func _physics_process(delta):
	if held:
		
		var dist_to_mouse = (position + local_grab_position).distance_to(get_global_mouse_position())
		
		if dist_to_mouse > 5:
			
			linear_damp = 10
			var move_direction = (get_global_mouse_position() - position - local_grab_position).normalized()

			apply_central_impulse(move_direction * 100 * (dist_to_mouse / 40) * (mass) )
		else:
			applied_torque = 0
			
		
	else:
		linear_damp = 0
		#var rotation_error = (position.angle_to_point(get_global_mouse_position())) - position.angle_to_point(position + local_grab_position)
		
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("grab"):
		
		local_grab_position = get_global_mouse_position() - position
		
		held = true

func _on_grab_stop():
	held = false

func _update_line():
	outline.clear_points()
	outline.points = _col_polygon2d.polygon
	outline.add_point(_col_polygon2d.polygon[0])
	
func setPolygon(poly : PoolVector2Array) -> void:
	.setPolygon(poly)
	_update_line()
