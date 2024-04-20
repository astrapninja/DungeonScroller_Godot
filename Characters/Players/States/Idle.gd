extends State
class_name PlayerIdle

@export var player : CharacterBody2D

func _Update(_delta : float):
	if player._isWalking():
		Transitioned.emit(self, "Walk")
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")

func _PhysicsUpdate(_delta : float):
	#print(player.lastDirectionX)
	#if player.velocity.x * player.inputDirection[0] > 0:
		#player.velocity.x -= player.inputDirection[0] * ((player.walkAcceleration*2.5) * _delta)
	pass
