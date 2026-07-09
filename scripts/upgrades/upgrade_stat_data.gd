extends UpgradeData

class_name UpgradeStatData

enum stat_upgrade_type {
	SPEED,
	STAMINA
}

@export var stat_type: stat_upgrade_type
@export var amount: float = 10.0