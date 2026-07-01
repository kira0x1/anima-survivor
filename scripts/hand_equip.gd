extends Marker2D

var item_spawned: Item
var has_equip: bool = false


func _on_actionbar_slot_changed(slot: ActionbarSlot) -> void:
	if slot.is_occupied:
		var new_item: Node = slot.slot_item.item_scene.instantiate()
		add_child(new_item)
		item_spawned = new_item
		has_equip = true
	else:
		has_equip = false
