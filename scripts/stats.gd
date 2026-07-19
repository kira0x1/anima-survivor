class_name Stats

var level: int = 1
var xp: float = 0.0
var max_xp: float = 100.0

var stamina: float = 1
var speed: float = 10
var weapon_range_bonus: float = 0.0
var attack_speed_bonus: float = 1.0

var global_damage_bonus: float = 0.0
var ranged_attack_bonus: float = 0.0
var melee_attack_bonus: float = 0.0

var crit_chance: float = 0.2
var crit_multiplier: float = 2.0

var attack_speed_mods: Array = []

func calculate_velocity() -> float:
	return speed * 12.0;
	
func calculate_attack_speed(weapon: WeaponData) -> float:
	return weapon.base_firerate + attack_speed_bonus

func calculate_attack_damage(weapon: WeaponData) -> DamageInfo:
	var r: float = randf()
	var is_crit: bool = r <= crit_chance
	
	var damage: float = weapon.base_damage + global_damage_bonus
	if is_crit:
		damage *= crit_multiplier
		
#	print("damage = (crit: %s, %0.2f) [weapon: %d] + [global: %d]" % [is_crit, r, weapon.base_damage, global_damage_bonus])
	
	if weapon.range_type == WeaponData.RangeType.MELEE:
		damage += melee_attack_bonus
	else:
		damage += ranged_attack_bonus
		
	var damage_info: DamageInfo = DamageInfo.new()
	damage_info.damage	= damage
	damage_info.is_crit = is_crit
	
	return damage_info
