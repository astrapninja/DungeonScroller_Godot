extends State
class_name PlayerSprint

@export var player : CharacterBody2D

func _Enter():
	if player.velocity.x * player.inputDirection[0] < player.sprintSpeed-124:
		player.velocity.x = player.inputDirection[0] * 50

func _Update(_delta : float):
	if !player._isWalking():
		Transitioned.emit(self, "Idle")
	elif !Input.get_action_strength("sprint"):
		Transitioned.emit(self, "Walk")
	elif Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
	elif player.velocity.y >= 0 and !player.is_on_floor():
		Transitioned.emit(self, "Fall")

func _PhysicsUpdate(_delta : float):
	if player.velocity.x * player.inputDirection[0] < player.sprintSpeed:
		player.velocity.x += player.inputDirection[0] * (player.sprintAcceleration * _delta)
		if player.velocity.x * player.inputDirection[0] > player.sprintSpeed:
			player.velocity.x = player.inputDirection[0] * player.sprintSpeed
	elif player.velocity.x * player.inputDirection[0] > player.sprintSpeed:
		player.velocity.x -= player.inputDirection[0] * (player.sprintAcceleration * _delta)
