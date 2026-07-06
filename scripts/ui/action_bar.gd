extends HBoxContainer

var slots: Array[ActionbarSlot]
var slot_selected_id: int = 0
var slot_selected

signal slot_changed(slot: ActionbarSlot)
#var apple: ItemData = preload("res://data/items/apple_item.tres")

const slot_input_map: Array[String] = ["slot_1", "slot_2", "slot_3", "slot_4", "slot_5", "slot_6", "slot_7"]

func _ready() -> void:
	slots = []
	var slot_children: Array = get_children().map(func(c: Node): return c as ActionbarSlot) as Array[ActionbarSlot]
	slots.append_array(slot_children)
	
	slot_selected_id = 0
	slots[slot_selected_id].select_slot()
#	slots[slot_selected_id].set_item(apple)
	select_slot(0)

func select_slot(slot_id):
	slots[slot_selected_id].deselect_slot()
	slots[slot_id].select_slot()

	slot_selected = slots[slot_id]
	slot_selected_id = slot_id
	
	slot_changed.emit(slot_selected)
	
func _input(event: InputEvent) -> void:
	for i in slot_input_map.size():
		if event.is_action_pressed(slot_input_map[i]):
			select_slot(i)
	
	if event.is_pressed():
		var next_slot: int = slot_selected_id
		
		if event.is_action("scroll_up"):
			next_slot = next_slot - 1
			if next_slot < 0: 
				next_slot = slots.size() - 1
			
			select_slot(next_slot)
			
		elif event.is_action("scroll_down"):
			next_slot += 1
			if next_slot >= slots.size(): 
				next_slot = 0
			select_slot(next_slot)
			

func has_free_slots() -> bool:
	var found_free: bool = false
	
	for slot in slots:
		if !slot.is_occupied:
			found_free = true
			break
	
	return found_free
	
func get_free_slot() -> int:
	var free_slot_index: int = -1
		
	var i:int = 0
	for slot in slots:
		if !slot.is_occupied:
			free_slot_index = i
			break
			
		i = i + 1

	return free_slot_index

func _on_player_on_gained_weapon(weapon_data: WeaponData) -> void:
	if !has_free_slots():
		print("no free slots found")
	else:
		var free_slot_index: int = get_free_slot()
		slots[free_slot_index].set_item(weapon_data)
		
