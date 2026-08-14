extends UpgradeData
class_name UpgradeStatData

enum StatType {
	SPEED,
	STAMINA,
	RANGE,
	DAMAGE,
	ATTACK_SPEED,
	RANGED_DAMAGE,
	MELEE_DAMAGE,
	CHARACTER_RANGE
}

enum StatValueType {
	FLAT,
	PERCENTAGE
}

@export var stat_type: StatType
@export var amount: float = 10.0

@export var value_type: StatValueType = StatValueType.FLAT
@export var tiers: Array[UpgradeTierData] = []