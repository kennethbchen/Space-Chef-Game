extends Label

var item_type: int

var item_name: String

export var good_color: Color
export var bad_color: Color

func init(item_type: int, item_name: String):
	self.item_type = item_type
	self.item_name = item_name
	

func _on_item_inserted(type, current_value, max_value):
	
	if type == item_type:
		text = "%s: %d/%d" % [item_name, current_value, max_value]
		
		if current_value == max_value:
			modulate = good_color
		elif current_value > max_value:
			modulate = bad_color

