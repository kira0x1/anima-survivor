extends Weapon
class_name RangedWeapon

@onready var range_indicator: Marker2D = %weapon_range
@onready var collider: CollisionShape2D = $CollisionShape2D

func _on_stats_updated():
	print("range: %0.1f" % collider.shape.radius)
	range_indicator.position.x = collider.shape.radius

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
