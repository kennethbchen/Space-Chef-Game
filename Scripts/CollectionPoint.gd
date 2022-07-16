extends Area2D


signal ingredient_inserted(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body: BaseObject):
	
	if body is BaseObject:
		
		print(Util.get_poly_stats(body.get_polygon()))
		
		emit_signal("ingredient_inserted", body.type)
		body.queue_free()

