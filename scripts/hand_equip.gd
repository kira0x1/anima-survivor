extends Marker2D

var weapons_spawned: Array[Variant] = []
var item_spawned: Variant
var has_equip: bool = false
var has_spawned_item: bool = false

func hide_item():
	item_spawned.set("visible", false)
	
func show_item():
	item_spawned.set("visible", true)

func _on_player_on_gained_weapon(weapon_data: WeaponData) -> void:
		if has_spawned_item:
			print("already has item spawned (%s) but trying to spawn %s" % [item_spawned.name, weapon_data.name])

		if weapon_data.get("item_scene") != null:
			var weapon_spawn: Node = weapon_data.item_scene.instantiate()
			add_child(weapon_spawn)
			item_spawned = weapon_spawn
			has_spawned_item = true
