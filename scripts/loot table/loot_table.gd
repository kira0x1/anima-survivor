extends Node

class_name LootTable

@export var items_table: Array[LootTableItem] = []

func generate_loot() -> Array[LootTableItem]:
	var drops: Array[LootTableItem] = []

	for item in items_table:
		var f: float = randf()
#		print("rng: %.2f / %.2f" % [f, item.chance])
		if item.chance >= f:
			drops.push_front(item)
	
	return drops
			

func spawn_item():
	var drops: Array[LootTableItem] = generate_loot()
	
	for item in drops:
		var item_spawn: Node2D = item.item_data.instantiate()
		call_deferred("add_child", item_spawn)
		item_spawn.set_deferred("global_position", owner.global_position)
