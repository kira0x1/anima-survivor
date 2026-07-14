extends Panel

class_name WeaponInventoryPanel

var weapon_cards: Array[InventoryWeaponCard] = []
@onready var weapon_grid: HBoxContainer = $WeaponGrid

func _ready() -> void:
	for cards in weapon_grid.get_children():
		weapon_cards.push_back(cards)

func has_free_slots() -> bool:
	var found_free: bool = false
	
	for card in weapon_cards:
		if !card.has_weapon:
			found_free = true
			break
	
	return found_free
	
func get_free_slot() -> int:
	var free_slot_index: int = -1
		
	var i:int = 0
	for card in weapon_cards:
		if !card.has_weapon:
			free_slot_index = i
			break
			
		i = i + 1

	return free_slot_index

func on_player_gained_weapon(weapon_data: WeaponData):
	if !has_free_slots():
		print("no free slots found")
	else:
		var free_slot_index: int = get_free_slot()
		weapon_cards[free_slot_index].set_weapon(weapon_data)