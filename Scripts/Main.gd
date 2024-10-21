extends Node2D

var baseRoom = preload("res://DungeonRooms/BaseRoom.tscn")
var currentRoom : Area2D
var loadedRooms : Dictionary
var nextRoom

var Rooms : Dictionary = {
	"BaseRoom" = preload("res://DungeonRooms/BaseRoom.tscn"),
}



func _ready():
	#Load First Room
	if !get_node("Rooms").get_child_count():
		baseRoom = baseRoom.instantiate()
		get_node("Rooms").add_child(baseRoom)
		baseRoom.body_shape_entered.connect(_Wom)
		$Player.gravity = true

func _loadNextRoom():
	nextRoom = Rooms[Rooms.keys().pick_random()]

func _Wom(body_rid : RID, body : Node2D, body_shape_index : int, local_shape_index : int):
	if body != $Player or body_shape_index != 0:
		return
	
	_loadNextRoom()
	
	
