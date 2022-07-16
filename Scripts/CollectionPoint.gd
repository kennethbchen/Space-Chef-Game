extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body: BaseObject):
	
	if body is BaseObject:
		
		print(PolyUtil.get_poly_stats(body.get_polygon()))
		
		body.queue_free()

