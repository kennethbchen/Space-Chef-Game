extends Area2D

onready var poly_debug = $"../PolyDebug"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body: BaseObject):
	
	if body is BaseObject:
		poly_debug.polygon = PolyUtil.get_bounding_box(body.get_polygon())
		poly_debug.polygon = PolygonLib.translatePolygon(poly_debug.polygon, Vector2(500,400))
		
		print(PolyUtil.get_poly_stats(body.get_polygon()))

