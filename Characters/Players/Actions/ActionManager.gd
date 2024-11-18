extends Node
class_name ActionsManager

@export var entity : CharacterBody2D
var actions : Dictionary
var attackDebug : bool = false

func _ready():
	for action in get_children():
		actions[action.name.to_lower()] = action

func _physics_process(delta):
	if Input.is_action_just_pressed("WeaponFire") and entity.find_child("weapon") and !attackDebug:
		if actions["weaponfire"]:
			actions["weaponfire"]._Fire()
