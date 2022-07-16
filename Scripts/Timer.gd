extends Control


onready var label = $Label

onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	label.text = str(int(timer.time_left))
