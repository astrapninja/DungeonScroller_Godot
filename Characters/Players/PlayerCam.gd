extends Camera2D

@export var player : CharacterBody2D
var currentArea : Area2D
var nextArea : Area2D
var tween : Tween

func _tweenTimeMultiplierX(area : Area2D):
	if (player.position.x - (area.find_child("Area").global_position.x + area.find_child("Area").shape.size.x/2)) < (player.position.x - (area.find_child("Area").global_position.x - area.find_child("Area").shape.size.x/2)):
		return player.closeTweenMultiplier
	return 1

func _tweenTimeMultiplierY(area : Area2D):
	if (player.position.y - (area.find_child("Area").global_position.y + area.find_child("Area").shape.size.y/2)) < (player.position.y - (area.find_child("Area").global_position.y - area.find_child("Area").shape.size.y/2)):
		return player.closeTweenMultiplier
	return 1

func _tween(valueName : String, value : int, time : float):
	tween = create_tween()
	tween.tween_property(self, valueName, value, time).set_trans(Tween.TRANS_LINEAR)

func _tweenLimits(area : Area2D):
	_tween("limit_right", area.find_child("Area").global_position.x + area.find_child("Area").shape.size.x/2, player.cameraTweenTime * _tweenTimeMultiplierX(area))
	_tween("limit_left", area.find_child("Area").global_position.x - area.find_child("Area").shape.size.x/2, player.cameraTweenTime * _tweenTimeMultiplierX(area))
	_tween("limit_bottom", area.find_child("Area").global_position.y + area.find_child("Area").shape.size.y/2, player.cameraTweenTime * _tweenTimeMultiplierY(area))
	_tween("limit_top", area.find_child("Area").global_position.y - area.find_child("Area").shape.size.y/2, player.cameraTweenTime * _tweenTimeMultiplierY(area))

func _changeLimits(area : Area2D):
	limit_left = area.find_child("Area").global_position.x - area.find_child("Area").shape.size.x/2
	limit_right = area.find_child("Area").global_position.x + area.find_child("Area").shape.size.x/2
	limit_bottom = area.find_child("Area").global_position.y + area.find_child("Area").shape.size.y/2
	limit_top = area.find_child("Area").global_position.y - area.find_child("Area").shape.size.y/2

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if currentArea != null:
		if nextArea == null:
			nextArea = area
		return
	
	currentArea = area
	_changeLimits(currentArea)
	limit_smoothed = true
	position_smoothing_enabled = true

func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area != currentArea:
		return
	
	if nextArea != null:
		currentArea = nextArea
		nextArea = null
		_tweenLimits(currentArea)

func _physics_process(delta):
	position_smoothing_speed = 5 + (5*(player.velocity.x*player.isPositive(player.velocity.x)/player.sprintSpeed))
