class_name Stats

var level: int = 1
var xp: float = 0.0
var max_xp: float = 100.0

var stamina: float = 1
var speed: float = 10
var weapon_range_bonus: float = 0.0
var attack_speed_bonus: float = 1.0

var attack_speed_mods: Array = []

func calculate_velocity() -> float:
	return speed * 12.0;
	
func calculate_attack_speed(weapon: WeaponData) -> float:
	return weapon.base_firerate + attack_speed_bonus
