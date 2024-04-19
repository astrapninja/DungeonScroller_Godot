extends State
class_name PlayerWalk

@export var player : CharacterBody2D

func _Enter():
	pass

func _Update(_delta : float):
	if !player._isWalking():
		Transitioned.emit(self, "Idle")

func _PhysicsUpdate(_delta : float):
	if player.velocity.x * player.inputDirection[0] < player.walkSpeed:
		player.velocity.x += player.inputDirection[0] * (player.walkAcceleration * _delta)
	elif player.velocity.x * player.inputDirection[0] > player.walkSpeed:
		player.velocity.x -= player.inputDirection[0] * ((player.walkAcceleration*2.5) * _delta)
		
	if player.velocity.x * player.inputDirection[0] > player.walkSpeed:
		player.velocity.x = player.inputDirection[0] * player.walkSpeed
