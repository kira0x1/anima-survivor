extends Control

class_name UpgradeSelection

# check if weapon is already equipped then maybe we give a stat upgrade to the weapon?
enum UpgradeType {STAT, WEAPON}
var cards: Array[UpgradeCard]

var has_upgrade_selected: bool = false

@export var upgrade_type: UpgradeType
@export var upgrade_weapons: Array[WeaponData] = []
@export var upgrade_tests: Array[UpgradeData] = []

func _ready() -> void:
	for child in find_children("card*"):
		cards.push_back(child)
	
	generate_cards()


func generate_cards():
	var i: int = 0

	var upgrade_pool: Array = upgrade_tests
	if upgrade_type == UpgradeType.WEAPON:
		upgrade_pool = upgrade_weapons
		
	for card in cards:
		var random_upgrade: int = randi_range(0, upgrade_pool.size()-1)
#		print("upgrade index: %d" % random_upgrade)
		card.init_card(upgrade_pool[random_upgrade], upgrade_type)
#		print("card: %s" % card.name)
		i = i + 1

func on_upgrade_selected(upgrade_card: UpgradeCard, upgrade_data: Resource) -> void:
	if has_upgrade_selected:
		return
		
	has_upgrade_selected = true
	
	var upgrade_name: String = ""
	
	if upgrade_card.upgrade_type == UpgradeType.STAT:
		upgrade_name = upgrade_data.upgrade_name
	else:
		upgrade_name = upgrade_data.weapon_name

	print("selected upgrade: %s" % upgrade_name)
