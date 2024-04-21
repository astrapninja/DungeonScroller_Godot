extends State
class_name PlayerFall

@export var player : CharacterBody2D

func _Update(_delta : float):
	if !player._isFalling():
		Transitioned.emit(self, "idle")
