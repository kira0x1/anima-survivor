extends LootOrb

class_name XpOrb

var xp: float = 10.0

func give_consume_award():
	player.give_xp(xp)
