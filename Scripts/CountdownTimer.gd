extends PopupPanel

onready var timer = $Timer
onready var label = $Label

var done = false

signal timer_done()

# Called when the node enters the scene tree for the first time.
func _ready():
	popup()


func _process(delta):
	
	label.text = "%d" % timer.time_left
	if timer.time_left < 1 and not done:
		timer.stop()
		done = true
		hide()
		emit_signal("timer_done")
	
	


