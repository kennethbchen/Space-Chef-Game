extends RigidBody2D


onready var collision_polygon2d = $CollisionPolygon2D
onready var polygon2d = $Polygon2D

export(Texture) var poly_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_polygon() -> PoolVector2Array:
	return polygon2d.get_polygon()

func set_polygon(poly : PoolVector2Array) -> void:
	collision_polygon2d.set_polygon(poly)
	polygon2d.set_polygon(poly)

func getTextureInfo() -> Dictionary:
	return {"texture" : polygon2d.texture, "rot" : polygon2d.texture_rotation, "offset" : polygon2d.texture_offset, "scale" : polygon2d.texture_scale}

func setTexture(texture_info : Dictionary) -> void:
	polygon2d.texture = texture_info.texture
	polygon2d.texture_scale = texture_info.scale
	polygon2d.texture_offset = texture_info.offset
	polygon2d.texture_rotation = texture_info.rot
