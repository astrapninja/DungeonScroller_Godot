extends Node
class_name StateMachine

@export var player : CharacterBody2D

var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(_On_Child_Transition)
	
	if player.initialState:
		player.currentState = player.initialState
		player.initialState._Enter()

func _process(delta):
	if player.currentState:
		player.currentState._Update(delta)

func _physics_process(delta):
	if player.currentState:
		player.currentState._PhysicsUpdate(delta)

func _On_Child_Transition(state, newStateName):
	if state != player.currentState:
		return
	
	if !states.get(newStateName.to_lower()):
		return
	
	if player.currentState:
		player.currentState._Exit()
	
	player.lastState = player.currentState
	player.currentState = states.get(newStateName.to_lower())
	
	player.currentState._Enter()
	
	#states.get(newStateName.to_lower())
	
	
	pass
