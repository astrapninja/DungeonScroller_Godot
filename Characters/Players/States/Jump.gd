extends State
class_name PlayerJump

@export var player : CharacterBody2D

func _Enter():
	player.velocity.y -= player.jumpStrength
	pass

func _Update(_delta : float):
	if player.velocity.y >= 0:
		Transitioned.emit(self, "Fall")# change to fall
	pass

func _PhysicsUpdate(_delta : float):
	pass
