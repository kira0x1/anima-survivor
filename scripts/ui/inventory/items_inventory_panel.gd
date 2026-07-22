extends Panel

class_name ItemsInventoryPanel

var item_slots: Array[InventoryItemSlot] = []

@export var slots_amount: int = 18
@onready var items_grid: GridContainer = $ItemSlots/MarginContainer/ItemsGrid

func _ready() -> void:
	for slots in items_grid.get_children():
		item_slots.push_back(slots)
	
	for i in slots_amount:
		create_slot()
	
	if item_slots.size() > 0:
		var slot_child: InventoryItemSlot = item_slots[0]
		var grid_width = items_grid.get_parent().size.x
		print("grid_scale.x %d / slot_size %d" % [grid_width, slot_child.size.y])
		var grid_column_size = floor(grid_width / slot_child.size.y)
		print("grid count: %d" % grid_column_size)
		items_grid.columns = grid_column_size
		
func create_slot():
	var slot_scene: PackedScene = preload("res://scenes/ui/inventory/inventory_item_slot.tscn")
	var new_slot: Node =  slot_scene.instantiate()
	items_grid.add_child(new_slot)
	item_slots.push_back(new_slot)

func has_free_slots() -> bool:
	var found_free: bool = false
	
	for slot in item_slots:
		if !slot.is_occupied:
			found_free = true
			break
	
	return found_free
	
func get_free_slot() -> int:
	var free_slot_index: int = -1
		
	var i:int = 0
	for slot in item_slots:
		if !slot.is_occupied:
			free_slot_index = i
			break
			
		i = i + 1

	return free_slot_index

func on_player_gained_bonus(upgrade_data: UpgradeData):
	if !has_free_slots():
		print("no free slots found")
	else:
		var free_slot_index: int = get_free_slot()
		item_slots[free_slot_index].set_item(upgrade_data)
