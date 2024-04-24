extends Action
class_name WeaponFire

func _Fire():
	if get_node("../../weapon/Area2D/CollisionShape2D"):
		get_node("../../weapon").hit.connect(_Damage)
		get_node("../../weapon/Area2D/CollisionShape2D").disabled = false
		await get_tree().create_timer(0.1).timeout
		get_node("../../weapon/Area2D/CollisionShape2D").disabled = true


func _Damage(weapon, area : Area2D):
	if !area.name == "HitboxComp":
		return
	if area.get_parent().find_child("HealthComp"):
		var attack = Attack.new()
		attack.attackDamage = get_parent().get_parent().find_child("weapon").damage
		area.get_parent().find_child("HealthComp")._Damage(attack)
		return
