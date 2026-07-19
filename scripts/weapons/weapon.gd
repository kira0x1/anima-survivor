extends Area2D

class_name Weapon

# TODO - create weapon class and inherit from it 

# dont attack if enemies this close
const MIN_RANGE: float = 40.0
const MAX_RANGE: float = 600.0

# basically fire rate for ranged weapons and how fast you swing when melee
@export var attack_speed: float = 0.8;
@export var damage: float = 10.0;

var has_target: bool = false
var target: Mob
var weapon_data: WeaponData
var stats: Stats

func _ready() -> void:
	var timer: Timer = %Timer
	timer.wait_time = attack_speed
	
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

func _on_timer_timeout() -> void:
	if has_target:
		attack()
