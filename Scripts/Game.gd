extends Node2D

export(PackedScene) var base_object

export(PackedScene) var ingredient_label

export(NodePath) var ingredient_label_parent_path
onready var ingredient_label_parent = get_node(ingredient_label_parent_path)

export(NodePath) var results_screen_path
onready var results_screen: PopupPanel = get_node(results_screen_path)

onready var object = $Object

onready var fracture_util = FractureUtil.new()

onready var objects = $Objects

onready var cut_line = $CutLine

onready var cut_start = Vector2.ZERO
onready var cut_end = Vector2.ZERO

var cutting = false

signal item_inserted(item_type)

var recipe = {
	BaseObject.object_type.CARROT: {
		"amount": 4
	},
	BaseObject.object_type.LEEK: {
		"amount": 6
	},
	BaseObject.object_type.POTATO: {
		"amount": 2
	}
}

var items_inserted = {}

var input_disabled = false

func _ready():
	fracture_util.init(base_object)
	
	_init_ingredient_labels()

func _process(delta):
	_draw_cut_line()

func _input(event: InputEvent):
	
	if input_disabled:
		return
	
	if event.is_action_pressed("cut"):
		
		cutting = true
		cut_start = get_global_mouse_position()
		
	elif event.is_action_released("cut"):
		
		if not cutting:
			return
		
		cutting = false
		cut_end = get_global_mouse_position()
		_cut(cut_start, cut_end)
		
	elif event.is_action_pressed("grab"):
		
		if cutting:
			cutting = false
			
	elif event.is_action_released("grab"):
		
		get_tree().call_group("grabbable", "_on_grab_stop")
	elif event.is_action_pressed("win"):
		_finish_game(true)
		
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


func _on_time_up():
	print("timer")
	pass

func _on_item_inserted(stats):
	
	if !items_inserted.has(stats.type):
		items_inserted[stats.type] = {"count": 0, "items": []}

	items_inserted[stats.type]["count"] += 1
	#items_inserted[stats.type]["items"].append(stats)
	
	emit_signal("item_inserted", stats.type, items_inserted[stats.type]["count"], recipe[stats.type]["amount"])
	
	if _is_recipe_complete():
		_finish_game(true)

func _is_recipe_complete():
	
	var complete = true
	
	for i in recipe.keys():
		
		if !items_inserted.has(i):
			complete = false
			break
		
		if items_inserted[i]["count"] < recipe[i]["amount"]:
			complete = false
			break
			
	return complete

func _init_ingredient_labels():
	
	for i in recipe.keys():
		var label = ingredient_label.instance()
		label.init(i, BaseObject.object_names[i])
		
		ingredient_label_parent.add_child(label)
		
		self.connect("item_inserted", label, "_on_item_inserted")

		emit_signal("item_inserted", i, 0, recipe[i]["amount"])

func _finish_game(recipe_complete = false):
	
	input_disabled = true
	results_screen.popup()
	pass

func _on_game_restart():
	get_tree().change_scene("res://Game.tscn")
	
	
	
