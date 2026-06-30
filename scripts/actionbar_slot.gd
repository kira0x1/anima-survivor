extends Button

var is_occupied: bool = false
var slot_item
var slot_id: int
var slot_text: Label

func _ready() -> void:
	slot_text = $slot_text
	slot_id = get_index()
	slot_text.text = "%d" % (slot_id + 1)

func SetItem(item):
	slot_item = item
	is_occupied = true;
