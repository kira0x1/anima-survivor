extends Control

class_name UpgradeSelection

# check if weapon is already equipped then maybe we give a stat upgrade to the weapon?
enum UpgradeType {STAT, WEAPON}
var cards: Array[UpgradeCard]

var has_upgrade_selected: bool = false
var is_upgrading: bool = false

@export var give_upgrade_on_start: bool = false
@export var upgrade_type: UpgradeType
@export var upgrade_weapons: Array[WeaponData] = []
@export var upgrade_tests: Array[UpgradeData] = []

func _ready() -> void:
	for child in find_children("card*"):
		cards.push_back(child)
	
	if give_upgrade_on_start:
		create_upgrades()

func create_upgrades():
	generate_cards()
	is_upgrading = true
	visible = true

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
		upgrade_name = upgrade_data.name
		give_weapon_upgrade(upgrade_data)

	print("selected upgrade: %s" % upgrade_name)
	

func give_weapon_upgrade(weapon_data: WeaponData):
	%Player.give_weapon(weapon_data)
	done_upgrading()
	
func done_upgrading():
	visible = false
	is_upgrading = false
