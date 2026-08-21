class_name RelicsHUD extends Panel

var relic_slots: Array[RelicSlot] = []

@export var slots_amount: int = 18
@onready var slot_grid: HBoxContainer = $BgPanel/Grid

func _ready() -> void:
	for slots in slot_grid.get_children():
		relic_slots.push_back(slots)

func has_free_slots() -> bool:
	var found_free: bool = false

	for slot in relic_slots:
		if ! slot.is_occupied:
			found_free = true
			break

	return found_free

func get_free_slot() -> int:
	var free_slot_index: int = -1

	var i: int = 0
	for slot in relic_slots:
		if ! slot.is_occupied:
			free_slot_index = i
			break

		i = i + 1

	return free_slot_index