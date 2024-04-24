extends Node2D
class_name HealthComp

@export var entity : CollisionObject2D

var maxHealth : float
var health : float

func _ready():
	#print(entity)
	maxHealth = entity.maxHealth
	health = maxHealth

func _Damage(attack : Attack):
	health -= attack.attackDamage
	if health <= 0:
		get_parent().queue_free()
