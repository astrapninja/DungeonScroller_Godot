extends Node2D

signal hit

@export var damage : float = 1

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area == get_node("../HitboxComp"):
		return
	hit.emit(self, area)

func _physics_process(delta):
	if get_node("..").is_class("CharacterBody2D"):
		get_node("Area2D/CollisionShape2D").global_position.x = get_node("../CollisionShape2D").global_position.x + ((get_node("Area2D/CollisionShape2D").shape.size.x/2 + get_node("../CollisionShape2D").shape.radius/2 + 5) * get_node("..").facingDirection[0])
		get_node("Area2D/CollisionShape2D").global_position.y = get_node("../CollisionShape2D").global_position.y + ((get_node("Area2D/CollisionShape2D").shape.size.y/2 + get_node("../CollisionShape2D").shape.height/2) * get_node("..").facingDirection[1])
