extends Node2D


onready var object = $Object

onready var cut_source = $CutSource

onready var fracture_util = FractureUtil.new()

onready var polygon_fracture = PolygonFracture.new()

onready var objects = $Objects

export(PackedScene) var base_object

# Called when the node enters the scene tree for the first time.
func _ready():
	fracture_util.init(base_object)
	pass # Replace with function body.

func _input(event: InputEvent):
	
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			_cut()
		
	
func _cut():
	var cut_rot = 0
	var cut_pos = cut_source.position
	
	var cut_shape = cut_source.polygon
	
	
	var cut_force = 20
	
	fracture_util.cutSourcePolygons(objects, cut_pos, cut_shape, cut_rot, cut_force)

	pass


