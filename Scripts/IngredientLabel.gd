extends Label

var item_type: int

var item_name: String

func init(item_type: int, item_name: String):
	self.item_type = item_type
	self.item_name = item_name
	

func _on_item_inserted(type, current_value, max_value):
	
	if type == item_type:
		text = "%s: %d/%d" % [item_name, current_value, max_value]

