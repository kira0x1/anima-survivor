extends Control

var cards: Array[UpgradeCard]
@export var upgrade_tests: Array[UpgradeData] = []

func _ready() -> void:
	for child in find_children("card*"):
		cards.push_back(child)
		
	
	var i: int = 0
	for card in cards:
		card.init_card(upgrade_tests[i])
		print("card: %s" % card.name)
		i = i + 1
