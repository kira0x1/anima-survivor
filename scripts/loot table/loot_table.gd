extends Node

class_name LootTable

@export var items_table: Array[LootTableItem] = []

func spawn_item():
	var picked_item = items_table.pick_random()
	var item_spawn: Node2D = picked_item.item_data.item_scene.instantiate()
	add_child(item_spawn)
	item_spawn.global_position = owner.global_position
