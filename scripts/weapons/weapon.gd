extends Area2D
class_name Weapon

# TODO - create weapon class and inherit from it 

# dont attack if enemies this close
const MIN_RANGE: float = 40.0
const MAX_RANGE: float = 600.0

# basically fire rate for ranged weapons and how fast you swing when melee
@export var attack_speed: float = 0.8;
@export var damage: float = 10.0;

# calculated attack speed
var final_attack_speed: float = 0.0

@onready var timer: Timer = %Timer

var has_target: bool = false
var target: Mob
var weapon_data: WeaponData
var stats: Stats

func update_stats():
	final_attack_speed = attack_speed

	# bonus attack speed is a percentage
	if (stats.attack_speed_bonus > 0.0):
		var perc: float = stats.attack_speed_bonus / 100.0
		var bonus: float = perc * attack_speed
		final_attack_speed = attack_speed - bonus
		print("calculating final attack speed %0.2f" % (final_attack_speed))

	# print("weapon %s attackspd = (%0.2f) [%0.2f, bonus: %0.1f]" % [weapon_data.name, final_attack_speed, attack_speed, stats.attack_speed_bonus])
	timer.wait_time = clamp(final_attack_speed, 0, 100)
	_on_stats_updated()

func _ready() -> void:
	timer.wait_time = attack_speed
# _weapon_init()

func filter_targets(bodies: Array[Node2D]) -> void:
	has_target = false

	if bodies.size() == 0:
		return

	for body in bodies:
		var t: Mob = body

		if t.is_dead:
			continue

		has_target = true
		target = t
		break

func _physics_process(_delta: float) -> void:
	var bodies: Array[Node2D] = get_overlapping_bodies()

	filter_targets(bodies)

	if has_target:
		look_at(target.global_position)


func can_attack() -> bool:
	var target_distance: float = target.get_player_distance()
	if target_distance <= MIN_RANGE: return false
	elif target_distance > MAX_RANGE: return false
	else: return true

func calculate_total_damage() -> DamageInfo:
	return stats.calculate_attack_damage(self.weapon_data)

func attack() -> void:
	pass

func _on_stats_updated():
	pass

func _weapon_init():
	pass

func _on_timer_timeout() -> void:
	if has_target:
		attack()
