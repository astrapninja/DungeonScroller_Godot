extends State
class_name PlayerIdle

@export var player : CharacterBody2D

func _Update(_delta : float):
	if player._isWalking():
		Transitioned.emit(self, "Walk")
	elif Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
	elif player.velocity.y >= 0 and !player.is_on_floor():
		Transitioned.emit(self, "Fall")

func _PhysicsUpdate(_delta : float):
	#print(player.lastDirectionX)
	#if player.velocity.x * player.inputDirection[0] > 0:
		#player.velocity.x -= player.inputDirection[0] * ((player.walkAcceleration*2.5) * _delta)
	pass
