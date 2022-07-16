extends Node2D


signal ingredient_inserted(stats)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body: BaseObject):
	
	if body is BaseObject:
		
		var stats = Util.get_poly_stats(body.get_polygon())
		stats["type"] = body.type
		
		print(stats)
		
		emit_signal("ingredient_inserted", stats)
		
		body.queue_free()

