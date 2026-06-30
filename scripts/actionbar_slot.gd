extends Button

var is_occupied: bool = false
var slot_item

func SetItem(item):
	slot_item = item
	is_occupied = true;
