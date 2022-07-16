class_name Util




static func get_bounding_box(polygon : PoolVector2Array):
	
	var output: PoolVector2Array = []
	
	var min_x = 99999999999
	var max_x = -99999999999
	var min_y = 99999999999
	var max_y = -99999999999
	
	for point in polygon:
		min_x = min(min_x, point.x)
		max_x = max(max_x, point.x)
		
		min_y = min(min_y, point.y)
		max_y = max(max_y, point.y)
		
	
	output = [Vector2(min_x, min_y), Vector2(min_x, max_y), Vector2(max_x, max_y), Vector2(max_x, min_y)]
	return output

static func get_poly_stats(polygon: PoolVector2Array):
	var side_count = polygon.size()
	
	var area = PolygonLib.getPolygonArea(polygon)
	
	var angles = []
	
	for i in polygon.size() - 2:
		
		var a_b = polygon[i + 1] - polygon[i]
		
		var b_c = polygon[i + 2] - polygon[i + 1]
		
		angles.append(abs(a_b.angle_to(b_c)))
	
	var a_b = polygon[polygon.size() - 2] - polygon[polygon.size() - 1]
	var b_c = polygon[polygon.size() - 1] - polygon[0]
	var c_d = polygon[0] - polygon[1]

	angles.append(abs(a_b.angle_to(b_c)))
	angles.append(abs(b_c.angle_to(c_d)))
	
	var avg_angle = 0
	
	for i in angles:
		avg_angle += i
		
	avg_angle /= polygon.size()
	
	avg_angle = rad2deg(avg_angle)
	
	var med_angle = angles[angles.size() / 2]
	
	var side_lengths = []
	for i in polygon.size() - 1:
		side_lengths.append(polygon[i].distance_to(polygon[i + 1]))
	side_lengths.append(polygon[polygon.size() - 1].distance_to(polygon[0]))
	
	var length_deviation = standard_deviation(side_lengths)
	
	return {"sides": side_count, "area": area, "length_deviation": length_deviation, "avg_angle": avg_angle}

static func standard_deviation(list: Array):
	var avg = 0.0
	
	for item in list:
		avg += item
	avg /= list.size()
	
	var sq_mean_diff = []
	for item in list:
		sq_mean_diff.append(pow(item - avg, 2))
	
	var sum_sq_mean_diff = 0.0
	for item in sq_mean_diff:
		sum_sq_mean_diff += item

	# This is for a sample of data even though we have a population but whatever
	var variance = sum_sq_mean_diff / (sq_mean_diff.size() - 1)
	
	return sqrt(variance)
