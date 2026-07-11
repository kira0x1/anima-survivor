extends Marker2D

var item_spawned: Variant
var has_equip: bool = false
var has_spawned_item: bool = false

var slot_selected_id: int = -1

func hide_item():
	item_spawned.set("visible", false)
	
func show_item():
	item_spawned.set("visible", true)

func _on_actionbar_slot_changed(_slot: ActionbarSlot) -> void:
	pass	
#	if slot.is_occupied and has_spawned_item:
#		if item_spawned.name != slot.slot_item.name:
#			item_spawned.queue_free()
#			has_spawned_item = false
#			spawn_item(slot)
#		elif item_spawned.name == slot.slot_item.name:
#			show_item()
#		else: spawn_item(slot)
#	elif has_spawned_item:
#		hide_item()	
#		has_equip = false

func spawn_item(slot: ActionbarSlot):
#		print("item: %s, scene: %s" % [slot.slot_item.name, slot.slot_item.get("item_scene")])
		if slot.slot_item.get("item_scene") != null:
#			print("found scene for: %s" % slot.slot_item.name)
			var new_item: Node = slot.slot_item.item_scene.instantiate()
			add_child(new_item)
			item_spawned = new_item
			has_spawned_item = true
			
		has_equip = true


func _on_player_on_gained_weapon(weapon_data: WeaponData) -> void:
		if weapon_data.get("item_scene") != null:
#			print("found scene for: %s" % slot.slot_item.name)
			var new_item: Node = weapon_data.item_scene.instantiate()
			add_child(new_item)
			item_spawned = new_item
			has_spawned_item = true
