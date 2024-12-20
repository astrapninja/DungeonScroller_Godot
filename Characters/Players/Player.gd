extends CharacterBody2D

signal landed

@export_category("State")
@export var currentState : State
@export var initialState : State
@export var lastState : State

@export_category("Movement")
@export var coyoteTime : float
@export var dashCooldown : float
@export var dashSpeed : float
@export var dashTime : float
@export var fallSpeed : float
@export var gravity : bool
var grounded : bool
@export var walkAcceleration : float
@export var walkSpeed : float
@export var sprintAcceleration : float
@export var sprintSpeed : float
@export var jumpStrength : float

@export_category("Camera")
@export var cameraTweenTime : float
@export var closeTweenMultiplier : float

@export_category("placeholderName")
@export var maxHealth : float

var attackDebug : bool = false
var inputDirection : Vector2
var facingDirection : Vector2
var lastDirectionX : int
var tempVar : int #TODO: Fix this and change it with something else
var coyoteTimer : Timer

func _accelerateFall(_delta : float):
	if !coyoteTimer:
		velocity.y += (ProjectSettings.get_setting("physics/2d/default_gravity") * _delta)
	elif coyoteTimer:
		velocity.y += ((ProjectSettings.get_setting("physics/2d/default_gravity")*0.1) * _delta)

func _addCoyoteTimer():
	coyoteTimer = Timer.new()
	coyoteTimer.wait_time = coyoteTime
	coyoteTimer.one_shot = true
	coyoteTimer.autostart = true
	coyoteTimer.timeout.connect(_coyoteTimeout)
	
	add_child(coyoteTimer)

func _coyoteTimeout():
	if coyoteTimer != null:
			coyoteTimer.queue_free()
			coyoteTimer = null

func _isFalling():
	if !gravity:
		return false
	
	if is_on_floor():
			return false
	return true

func isPositive(number : int):
	if number < 0:
		return -1
	return 1

func _isWalking():
	for input in ["left", "right"]:
		if Input.get_action_strength(input):
			if Input.get_action_strength("left") and Input.get_action_strength("right"):
				return false
			return true
	return false

func _physics_process(_delta):
	
	inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	if inputDirection[0] != lastDirectionX and inputDirection[0]:
		lastDirectionX = inputDirection[0]
	
	if inputDirection[1] != 0:
		facingDirection = inputDirection
	elif inputDirection[1] == 0:
		facingDirection[1] = 0
		facingDirection[0] = lastDirectionX
	
	if velocity.x != 0 and currentState.name.to_lower() != "jump" and !_isFalling():
		tempVar = isPositive(velocity.x)
		velocity.x -= tempVar * ((walkAcceleration*0.4) * _delta)
		if velocity.x * tempVar < 0:
			velocity.x = 0
	
	if _isFalling() and velocity.y < fallSpeed:
		if grounded:
			_addCoyoteTimer()
			grounded = false
		_accelerateFall(_delta)
	elif !_isFalling():
		if coyoteTimer != null:
			coyoteTimer.queue_free()
			coyoteTimer = null
		grounded = true
	
	move_and_slide()
