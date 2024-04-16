extends Node
class_name State

signal Transitioned

func _Enter():
	print("Base State Entered")
	pass

func _Exit():
	pass

func _Update(_delta : float):
	pass

func _PhysicsUpdate(_delta : float):
	pass
