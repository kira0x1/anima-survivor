extends Button

var is_occupied: bool = false
var is_selected: bool = false
var highlight: Panel

var slot_item
var slot_id: int
var slot_text: Label

func _ready() -> void:
	slot_text = $slot_text
	highlight = $selected_highlight

	slot_id = get_index()
	slot_text.text = "%d" % (slot_id + 1)

func select_slot():
	is_selected = true
	highlight.visible = true

func deselect_slot():
	is_selected = false
	highlight.visible = false
	
func SetItem(item):
	slot_item = item
	is_occupied = true;
