extends Weapon
class_name RangedWeapon

# @onready var range_indicator: Marker2D = %weapon_range
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var range_line: Line2D = $weapon_pivot/Line2D

func _on_stats_updated():
	update_range()

func update_range():
	collider.shape.radius = weapon_data.base_range + stats.weapon_range_bonus

	var i: int = 0
	var size: int = range_line.points.size()

	for p in range_line.points:
		var s: float = ((i + 1.0) / size) * collider.shape.radius
		range_line.set_point_position(i, Vector2(s, 0))
		i = i + 1

func _weapon_init():
	update_range()

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
