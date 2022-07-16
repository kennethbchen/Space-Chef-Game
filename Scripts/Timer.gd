extends Control


onready var label = $Label

onready var timer = $Timer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):

	
	if timer.time_left > 1:
		label.align = HALIGN_CENTER
		label.text = ("%d" % timer.time_left)
	else:
		label.align = HALIGN_LEFT
		label.text = ("%0.2f" % timer.time_left)

	
