extends State
class_name PlayerJump

@export var player : CharacterBody2D

func _Enter():
	player.velocity.y -= player.jumpStrength
	pass

func _Update(_delta : float):
	if player.velocity.y >= 0 and !player.is_on_floor():
		Transitioned.emit(self, "Fall")# change to fall
	pass

func _PhysicsUpdate(_delta : float):
	if Input.get_action_strength("left") and player.velocity.x * player.inputDirection[0] < player.walkSpeed/2:
		player.velocity.x -= player.walkAcceleration/2 * _delta
	elif Input.get_action_strength("right") and player.velocity.x * player.inputDirection[0] < player.walkSpeed/2:
		player.velocity.x += player.walkAcceleration/2 * _delta
