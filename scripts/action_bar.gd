extends HBoxContainer

var slots: Array
var slot_selected_id: int = 0
var slot_selected

signal slot_changed(slot: ActionbarSlot)
#var apple: ItemData = preload("res://items/apple_item.tres")

const slot_input_map: Array[String] = ["slot_1", "slot_2", "slot_3", "slot_4", "slot_5", "slot_6", "slot_7"]

func _ready() -> void:
	slots = get_children()

	slot_selected_id = 0
	slots[slot_selected_id].select_slot()
#	slots[slot_selected_id].set_item(apple)
	
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

		elif event.is_action("scroll_down"):
			next_slot += 1
			if next_slot >= slots.size(): 
				next_slot = 0
		else:
			return

		select_slot(next_slot)
