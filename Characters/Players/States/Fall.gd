extends State
class_name PlayerFall

@export var player : CharacterBody2D

func _Update(_delta : float):
	if !player._isFalling():
		Transitioned.emit(self, "idle")

func _PhysicsUpdate(_delta):
	if Input.get_action_strength("left") and player.velocity.x * player.inputDirection[0] < player.walkSpeed/2:
		player.velocity.x -= player.walkAcceleration/2 * _delta
	elif Input.get_action_strength("right") and player.velocity.x * player.inputDirection[0] < player.walkSpeed/2:
		player.velocity.x += player.walkAcceleration/2 * _delta
