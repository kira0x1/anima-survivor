extends LootOrb

class_name XpOrb

var xp: float = 20.0

func give_consume_award():
	player.give_xp(xp)
