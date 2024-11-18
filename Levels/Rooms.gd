extends Node

var availableRooms : Dictionary = {
	"baseroom" = [preload("res://DungeonRooms/BaseRoom.tscn"), preload("res://DungeonRooms/StartRoom.tscn")],
	"startroom" = [preload("res://DungeonRooms/BaseRoom.tscn"), preload("res://DungeonRooms/StartRoom.tscn")]
}

@export var currentRoom : DungeonRoom
var loadedRooms : Dictionary
var newRoom : DungeonRoom

func _ready():
	for Room in get_children():
		if Room is DungeonRoom:
			_RegisterRoom(Room)

func _RegisterRoom(area : DungeonRoom):
	loadedRooms[loadedRooms.size()+1] = area
	area.PlayerEnteredRoom.connect(_LoadNextRoom)

func _LoadNextRoom(Room : DungeonRoom):
	if !loadedRooms[loadedRooms.find_key(Room)] or loadedRooms[loadedRooms.find_key(Room)].hasTouched:
		return
	
	Room.hasTouched = true
	newRoom = availableRooms[Room.roomCategory.to_lower()].pick_random().instantiate()
	
	add_child(newRoom)
	_RegisterRoom(newRoom)
	
	#TODO: This entire function is an afront to coding - FIX IT!
	newRoom.position.x = (loadedRooms[loadedRooms.size()-1].position.x + get_node(loadedRooms[loadedRooms.size()].name+"/Area").shape.size.x/2 + get_node(newRoom.name+"/Area").shape.size.x/2)
	#newRoom.position.y = (loadedRooms[loadedRooms.size()].position.y + get_node(loadedRooms[loadedRooms.size()].name+"/Area").shape.size.y/2 + get_node(newRoom.name+"/Area").shape.size.y/2)
