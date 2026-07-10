extends LootOrb

const HEAL_AMOUNT: float = 10.0

func give_consume_award():
	player.heal(HEAL_AMOUNT)