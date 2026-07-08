extends Node

class_name LootTable

@export var items_table: Array[LootTableItem] = []

func spawn_item():
	var picked_item: LootTableItem = items_table.pick_random()
	var item_spawn: Node2D = picked_item.item_data.instantiate()
#	add_child(item_spawn)
	call_deferred("add_child", item_spawn)
	item_spawn.set_deferred("global_position", owner.global_position)
#	item_spawn.global_position = owner.global_position
