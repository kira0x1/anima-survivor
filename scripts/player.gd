extends CharacterBody2D

class_name Player

signal on_level_up
signal on_damage
signal on_heal
signal on_xp_change
signal on_stat_change
signal on_gained_weapon(weapon_data: WeaponData)

@export var player_character: PlayerCharacter
@onready var player_anim: AnimatedSprite2D = $Colorizer/Sprite

var stats: Stats = Stats.new()
var health: float = 100.0;
var max_health: float = 100.0
var is_alive: bool = true

var lastDirection: Vector2 = Vector2(0,0);
var direction: Vector2 = Vector2(0,0);

func _ready() -> void:
	stats.speed = player_character.speed
	stats.stamina = player_character.stamina
	give_weapon(player_character.starting_weapon)

func _physics_process(_delta: float) -> void:
	velocity = direction * stats.calculate_velocity()
	move_and_slide()

func _process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player_anim.move(velocity)

func take_damage(damage: float) -> void:
	if not is_alive:
		return

	health -= damage;
	
	if health <= 0.0:
		is_alive = false
		health = 0
		
	on_damage.emit()

func give_weapon(weapon_data: WeaponData):
	on_gained_weapon.emit(weapon_data)

func give_xp(xp: float):
	stats.xp += xp
	
	if stats.xp >= stats.max_xp:
		level_up()
	
	on_xp_change.emit()

func level_up():
	stats.xp = 0.0
	stats.level = stats.level + 1
	on_level_up.emit()
	
func give_stat(upgrade_stat_data: UpgradeStatData):
	var stat_type: UpgradeStatData.StatType = upgrade_stat_data.stat_type
	
	print("stat gained: %s, amount: %d" % [UpgradeStatData.StatType.keys()[upgrade_stat_data.stat_type], upgrade_stat_data.amount])
	
	if stat_type == UpgradeStatData.StatType.SPEED:
		stats.speed += upgrade_stat_data.amount
	elif stat_type == UpgradeStatData.StatType.RANGE:
		stats.weapon_range_bonus += upgrade_stat_data.amount
	elif stat_type == UpgradeStatData.StatType.ATTACK_SPEED:
		stats.attack_speed_bonus += upgrade_stat_data.amount
	elif stat_type == UpgradeStatData.StatType.DAMAGE:
		stats.global_damage_bonus += upgrade_stat_data.amount
	elif stat_type == UpgradeStatData.StatType.RANGED_DAMAGE:
		stats.ranged_attack_bonus += upgrade_stat_data.amount
	elif stat_type == UpgradeStatData.StatType.MELEE_DAMAGE:
		stats.melee_attack_bonus += upgrade_stat_data.amount
	
	on_stat_change.emit()

func heal(amount: float):
	health += amount
	health = clamp(health, 0.0, max_health)
	on_heal.emit()
