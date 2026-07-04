extends Marker2D

var item_spawned: Item
var has_equip: bool = false
var has_spawned_item: bool = false

var slot_selected_id: int = -1

func hide_item():
	item_spawned.set("visible", false)
	
func show_item():
	item_spawned.set("visible", true)

func _on_actionbar_slot_changed(slot: ActionbarSlot) -> void:
	if slot.is_occupied:
		if has_spawned_item:
			if item_spawned.item_name != slot.slot_item.name:
				item_spawned.queue_free()
				has_spawned_item = false
			elif item_spawned.item_name == slot.slot_item.name:
				show_item()
		else:
			if slot.slot_item.get("item_scene") != null:
				var new_item: Node = slot.slot_item.item_scene.instantiate()
				add_child(new_item)
				item_spawned = new_item
				has_spawned_item = true
				
			has_equip = true

	elif has_spawned_item:
		hide_item()	
		has_equip = false
		
