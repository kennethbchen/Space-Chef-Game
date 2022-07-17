extends Control


onready var label = $Label

onready var timer = $Timer

var elapsed_time = 0

var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):

	if running:
		elapsed_time += delta
	
	label.text = "%0.2f" % elapsed_time
	


func stop_timer():
	running = false
	
func start_timer():
	running = true

