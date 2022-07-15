class_name FractureUtil




# MIT License
# -----------------------------------------------------------------------
#                       This file is part of:                           
#                     GODOT Polygon 2D Fracture                         
#           https://github.com/SoloByte/godot-polygon2d-fracture          
# -----------------------------------------------------------------------
# Copyright (c) 2021 David Grueneis
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# Compilation of code from SoloByte's Godot Fracturing Library
# https://github.com/SoloByte/godot-polygon2d-fracture

var polyFracture = PolygonFracture.new()

var base_object

func _ready():
	pass

func init(base_obj):
	base_object = base_obj

func cutSourcePolygons(object_parent: Node, cut_pos : Vector2, cut_shape : PoolVector2Array, cut_rot : float, cut_force : float = 0.0, fade_speed : float = 2.0) -> void:
	
	for source in object_parent.get_children():
		var source_polygon : PoolVector2Array = source.get_polygon()
		var total_area : float = PolygonLib.getPolygonArea(source_polygon)
		
		var source_trans : Transform2D = source.get_global_transform()
		var cut_trans := Transform2D(cut_rot, cut_pos)
		
		var s_lin_vel := Vector2.ZERO
		var s_ang_vel : float = 0.0
		var s_mass : float = 0.0
		
		if source is RigidBody2D:
			s_lin_vel = source.linear_velocity
			s_ang_vel = source.angular_velocity
			s_mass = source.mass
		
		
		var cut_fracture_info : Dictionary = polyFracture.cutFracture(source_polygon, cut_shape, source_trans, cut_trans, 50, 20, 10, 1)
		if cut_fracture_info.shapes.size() <= 0 and cut_fracture_info.fractures.size() <= 0:
			continue
		
#		for fracture in cut_fracture_info.fractures:
#			for fracture_shard in fracture:
#				var area_p : float = fracture_shard.area / total_area
#
#				spawnFractureBody(fracture_shard, source.getTextureInfo(), s_mass * area_p)
		
		
		for shape in cut_fracture_info.shapes:
			
			var area_p : float = shape.area / total_area
			var mass : float = s_mass * area_p
			var dir : Vector2 = (shape.spawn_pos - cut_pos).normalized()
			
			_spawnRigidBody2D( object_parent, shape, source.modulate, s_lin_vel + dir * cut_force, s_ang_vel, mass, cut_pos, source.getTextureInfo())
		
		source.queue_free()

func _spawnRigidBody2D(object_parent: Node, shape_info : Dictionary, color : Color, lin_vel : Vector2, ang_vel : float, mass : float, cut_pos : Vector2, texture_info : Dictionary):
	var instance = base_object.instance()
	object_parent.add_child(instance)
	instance.global_position = shape_info.spawn_pos
	instance.global_rotation = shape_info.spawn_rot
	instance.set_polygon(shape_info.centered_shape)
	instance.modulate = color
	instance.linear_velocity = lin_vel
	instance.angular_velocity = ang_vel
	instance.mass = mass
	instance.setTexture(PolygonLib.setTextureOffset(texture_info, shape_info.centroid))
	pass
