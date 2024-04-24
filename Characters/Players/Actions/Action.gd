extends Node
class_name Action

var player
@export var cooldown : float

func _ready():
	player = get_node("../..")

func _Fire():
	pass
