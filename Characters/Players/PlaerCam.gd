extends Camera2D

@export var player : CharacterBody2D
var currentArea : StaticBody2D

#func _getArea():
	#for i in player.get_slide_collision_count():
		#if player.get_slide_collision(i).get_collider().has_meta("ID"):
			#print("SOMETHING")
		#if player.get_slide_collision(i).get_collider().get_meta("ID") == "Room":
			#print("ok")
			#return false
	#pass

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	limit_left = area.find_child("CollisionShape2D").global_position.x - area.find_child("CollisionShape2D").shape.size.x/2
	limit_right = area.find_child("CollisionShape2D").global_position.x + area.find_child("CollisionShape2D").shape.size.x/2
	limit_bottom = area.find_child("CollisionShape2D").global_position.y + area.find_child("CollisionShape2D").shape.size.y/2
	limit_top = area.find_child("CollisionShape2D").global_position.y - area.find_child("CollisionShape2D").shape.size.y/2
	pass # Replace with function body.
