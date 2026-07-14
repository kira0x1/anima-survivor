extends Button

class_name InventoryBonusSlot

var is_occupied: bool = false
var is_selected: bool = false
var highlight: Panel

var slot_item: Resource
var slot_id: int

func _ready() -> void:
	highlight = $selected_highlight
	slot_id = get_index()

func select_slot():
	is_selected = true
#	highlight.visible = true

func deselect_slot():
	is_selected = false
#	highlight.visible = false
	
func set_item(item):
	slot_item = item
	icon = slot_item.icon
	is_occupied = true;
