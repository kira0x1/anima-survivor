class_name RelicSlot extends Button

var is_occupied: bool = false
var is_selected: bool = false

var slot_item: Resource
var slot_id: int

func _ready() -> void:
	slot_id = get_index()

func select_slot():
	is_selected = true

func deselect_slot():
	is_selected = false

func set_item(item):
	slot_item = item
	icon = slot_item.icon
	is_occupied = true;

