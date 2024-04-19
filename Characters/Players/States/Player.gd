extends CharacterBody2D

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
@export var sprintSpeed : float
@export var jumpStrength : float

@export_category("PlaceholderHELP")
@export var placeholderHELP : String

var inputDirection : Vector2
var lastDirectionX : int
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
	if coyoteTimer:
		remove_child(coyoteTimer)
		coyoteTimer.queue_free()

func _isFalling():
	if !gravity:
		return false
	
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider().name == "Floor":
			return false
	return true

func _isWalking():
	for input in ["left", "right"]:
		if Input.get_action_strength(input):
			return true
	return false

func _physics_process(_delta):
	
	inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	if inputDirection[0] != lastDirectionX:
		lastDirectionX = inputDirection[0]
	
	if _isFalling() and velocity.y < fallSpeed and currentState.name.to_lower() != "Jump":
		if grounded:
			_addCoyoteTimer()
			grounded = false
		_accelerateFall(_delta)
	elif !_isFalling():
		grounded = true
	
	move_and_slide()
