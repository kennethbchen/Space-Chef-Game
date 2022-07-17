extends PopupPanel

onready var ingredient_stats = $MainContainer/MessageContainer/StatsContainer/IngredientLabel
onready var time_label = $MainContainer/MessageContainer/StatsContainer/TimeLabel
onready var cut_stats_label = $MainContainer/MessageContainer/StatsContainer/StatsLabel

func _ready():
	pass # Replace with function body.

func show_screen(game_data):
	
	ingredient_stats.text = game_data["ingredient_stats"]
	time_label.text = game_data["time"]
	cut_stats_label.text = game_data["cut_stats"]
	popup()
	
