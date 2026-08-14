class_name Stats

var level: int = 1
var xp: float = 0.0
var max_xp: float = 100.0

var stamina: float = 1
var stamina_bonus: float = 0.0
var total_stamina: float = stamina + stamina_bonus

var speed: float = 10
var speed_bonus: float = 0.0
var total_speed: float = speed + speed_bonus

var character_range: float = 0.0
var character_range_bonus: float = 0.0
var character_total_range: float = 0.0

var weapon_range_bonus: float = 0.0
var attack_speed_bonus: float = 0.0

var global_damage_bonus: float = 0.0
var ranged_attack_bonus: float = 0.0
var melee_attack_bonus: float = 0.0

var crit_chance: float = 0.2
var crit_chance_bonus: float = 0.0

var crit_multiplier: float = 2.0
var crit_mult_bonus: float = 0.0

var attack_speed_mods: Array = []

func init(player_character: PlayerCharacter):
	set_speed(player_character.speed)
	set_stamina(player_character.stamina)

	global_damage_bonus = player_character.global_damage_bonus
# print("player character speed: %0.1f / %0.1f" % [speed, total_speed])

func set_stamina(amount: float):
	stamina = amount
	refresh_stamina()

# sets base speed
func set_speed(amount: float):
	speed = amount
	refresh_speed()

func refresh_speed():
	total_speed = speed + speed_bonus

func refresh_stamina():
	total_stamina = stamina + stamina_bonus

func add_stat(stat_type: UpgradeStatData.StatType, amount: float):
	if stat_type == UpgradeStatData.StatType.SPEED:
		speed_bonus += amount
		refresh_speed()
	elif stat_type == UpgradeStatData.StatType.STAMINA:
		stamina_bonus += amount
		refresh_stamina()
	elif stat_type == UpgradeStatData.StatType.RANGE:
		weapon_range_bonus += amount
	elif stat_type == UpgradeStatData.StatType.ATTACK_SPEED:
		attack_speed_bonus += amount
	elif stat_type == UpgradeStatData.StatType.DAMAGE:
		global_damage_bonus += amount
	elif stat_type == UpgradeStatData.StatType.RANGED_DAMAGE:
		ranged_attack_bonus += amount
	elif stat_type == UpgradeStatData.StatType.MELEE_DAMAGE:
		melee_attack_bonus += amount

func calculate_velocity() -> float:
	return total_speed * 3.0;

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
	damage_info.damage = damage
	damage_info.is_crit = is_crit

	return damage_info
