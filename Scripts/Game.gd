extends Node2D


onready var object = $Object

onready var fracture_util = FractureUtil.new()

onready var objects = $Objects

onready var cut_line = $CutLine

onready var cut_start = Vector2.ZERO
onready var cut_end = Vector2.ZERO

var cutting = false

export(PackedScene) var base_object

func _ready():
	fracture_util.init(base_object)

func _process(delta):
	_draw_cut_line()

func _input(event: InputEvent):
	
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			cutting = true
			cut_start = get_global_mouse_position()
		elif event.button_index == 1:
			cutting = false
			cut_end = get_global_mouse_position()
			_cut(cut_start, cut_end)
		
func _draw_cut_line():
	
	cut_line.clear_points()
	
	if !cutting:
		return

	cut_line.add_point(cut_start)
	cut_line.add_point(get_global_mouse_position())


# References CutFracture.gd from fracturing library
func _cut(start: Vector2, end: Vector2):
	
	# Enforce Minimum Length
	if start.distance_to(end) <= 5:
		return
	
	var cut_pos = Vector2.ZERO
	
	var cut_line = PoolVector2Array([start,end])
	var cut_shape: PoolVector2Array = [] 
	cut_shape = PolygonLib.offsetPolyline(cut_line, 1)[0]
	cut_shape = PolygonLib.translatePolygon(cut_shape, -start)
	
	var cut_rot = 0

	var cut_force = 20

	fracture_util.cutSourcePolygons(objects, start, cut_shape, cut_rot, cut_force)



