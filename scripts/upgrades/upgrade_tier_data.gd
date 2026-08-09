class_name UpgradeTierData extends Resource

enum StatValueType {
	FLAT,
	PERCENTAGE
}

enum Tier {
	COMMON,
	UNCOMMON,
	RARE,
	VERY_RARE
}

@export var amount: float = 10.0
@export var value_type: StatValueType = StatValueType.FLAT
@export var tier: Tier = Tier.COMMON
