extends LootOrb

class_name XpOrb

var xp: float = 10.0

func give_consume_award():
	%Player.give_xp(xp)
	print("giving consume award")