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
@export var upgrade_stats: Array[UpgradeStatData] = []

func _ready() -> void:
	for child in find_children("card*"):
		cards.push_back(child)
	
	if give_upgrade_on_start:
		create_upgrades()

func create_upgrades():
	generate_cards()
	is_upgrading = true
	visible = true
	get_tree().paused = true

func get_random_unique(upgrade_pool: Array, upgrades_selected: Array[int]):
	var random_upgrade: int = randi_range(0, upgrade_pool.size()-1)

	if upgrades_selected.has(random_upgrade):
		return get_random_unique(upgrade_pool, upgrades_selected)
	else:
		return random_upgrade

func generate_cards():
	var i: int = 0

	var upgrade_pool: Array = upgrade_stats
	var upgrades_selected: Array[int] = []
	
	if upgrade_type == UpgradeType.WEAPON:
		upgrade_pool = upgrade_weapons
		
	for card in cards:
		var random_upgrade: int = get_random_unique(upgrade_pool, upgrades_selected)
		upgrades_selected.push_back(random_upgrade)
		
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
		give_stat_upgrade(upgrade_data)
	else:
		upgrade_name = upgrade_data.name
		give_weapon_upgrade(upgrade_data)

func give_stat_upgrade(upgrade_data: UpgradeStatData):
	%Player.give_stat(upgrade_data)
	done_upgrading()

func give_weapon_upgrade(weapon_data: WeaponData):
	%Player.give_weapon(weapon_data)
	done_upgrading()
	
func done_upgrading():
	visible = false
	is_upgrading = false
	has_upgrade_selected = false
	get_tree().paused = false
	
func _on_player_on_level_up() -> void:
	upgrade_type = UpgradeType.STAT
	create_upgrades()
