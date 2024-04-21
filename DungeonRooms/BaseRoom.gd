extends Node
class_name DungeonRoom

signal PlayerEnteredRoom

@export var roomCategory : String
var hasTouched = false

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body != get_node("../../Player") or body_shape_index != 0:
		return
		
	PlayerEnteredRoom.emit(self)
