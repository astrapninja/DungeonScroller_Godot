extends CharacterBody2D

@export_category("State")
@export var currentState : State
@export var initialState : State
@export var lastState : State
@export_category("Movement")
@export var dashCooldown : float
@export var dashSpeed : float
@export var dashTime : float
@export var Speed : float
@export var sprintSpeed : float
@export var jumpStrength : float

@export_category("PlaceholderHELP")
@export var placeholderHELP : String


func _physics_process(delta):
	move_and_slide()
