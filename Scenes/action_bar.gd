extends HBoxContainer

var slots: Array
var slot_selected_id: int = 0
var slot_selected

func _ready() -> void:
	slots = get_children()

	slot_selected_id = 0
	slots[slot_selected_id].select_slot()
	

func select_slot(slot_id):
	slots[slot_selected_id].deselect_slot()
	slots[slot_id].select_slot()
	slot_selected_id = slot_id
	
func _input(event: InputEvent) -> void:
	if event.is_pressed():
		var next_slot: int = slot_selected_id
		
		if event.is_action("scroll_down"):
			next_slot = next_slot - 1
			if next_slot < 0: 
				next_slot = slots.size() - 1

		elif event.is_action("scroll_up"):
			next_slot += 1
			if next_slot >= slots.size(): 
				next_slot = 0
		else:
			return

		select_slot(next_slot)
			
