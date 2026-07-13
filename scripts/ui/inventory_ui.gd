extends Control

var weapon_cards: Array[InventoryWeaponCard] = []
@onready var weapon_grid: HBoxContainer = $"MainPanel/WeaponPanel/Weapon Grid"

func _ready() -> void:
	for cards in weapon_grid.get_children():
		weapon_cards.push_back(cards)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		toggle_ui()

func toggle_ui() -> void:
	visible = !visible


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


func _on_player_on_gained_weapon(weapon_data: WeaponData) -> void:
	if !has_free_slots():
		print("no free slots found")
	else:
		var free_slot_index: int = get_free_slot()
		weapon_cards[free_slot_index].set_weapon(weapon_data)	
