extends Weapon

class_name RangedWeapon

func attack() -> void:
	if not can_attack():
		print("cant attack...")
		return
	
	const ARROW: PackedScene = preload("res://scenes/arrow.tscn")
	var new_arrow: Node = ARROW.instantiate()
	new_arrow.global_position = %ShootingPoint.global_position
	new_arrow.global_rotation = %ShootingPoint.global_rotation
	var dmg_info: DamageInfo = calculate_total_damage()
	new_arrow.damage_info = dmg_info
	%ShootingPoint.add_child(new_arrow)
