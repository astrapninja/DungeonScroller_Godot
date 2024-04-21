extends State
class_name PlayerWalk

@export var player : CharacterBody2D

func _Enter():
	if player.lastState.name.to_lower() == "sprint":
		return
	if player.velocity.x * player.inputDirection[0] < player.walkSpeed-21:
		player.velocity.x = player.inputDirection[0] * 20

func _Update(_delta : float):
	if !player._isWalking():
		Transitioned.emit(self, "Idle")
	elif Input.get_action_strength("sprint"):
		Transitioned.emit(self, "Sprint")
	elif Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")

func _PhysicsUpdate(_delta : float):
	if player.velocity.x * player.inputDirection[0] < player.walkSpeed:
		player.velocity.x += player.inputDirection[0] * (player.walkAcceleration * _delta)
		if player.velocity.x * player.inputDirection[0] > player.walkSpeed:
			player.velocity.x = player.inputDirection[0] * player.walkSpeed
	elif player.velocity.x * player.inputDirection[0] > player.walkSpeed:
		player.velocity.x -= player.inputDirection[0] * (player.walkAcceleration * _delta)
