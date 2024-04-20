extends State
class_name PlayerWalk

@export var player : CharacterBody2D

func _Enter():
	if player.velocity.x * player.inputDirection[0] < player.walkSpeed-21:
		player.velocity.x = player.inputDirection[0] * 20
	pass

func _Update(_delta : float):
	if !player._isWalking():
		Transitioned.emit(self, "Idle")
	elif Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")

func _PhysicsUpdate(_delta : float):
	if player.velocity.x * player.inputDirection[0] < player.walkSpeed:
		player.velocity.x += player.inputDirection[0] * (player.walkAcceleration * _delta)
	elif player.velocity.x * player.inputDirection[0] > player.walkSpeed:
		player.velocity.x -= player.inputDirection[0] * (player.walkAcceleration * _delta)
		
	if player.velocity.x * player.inputDirection[0] > player.walkSpeed:
		player.velocity.x = player.inputDirection[0] * player.walkSpeed
