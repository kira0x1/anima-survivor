extends Panel

class_name BonusInventoryPanel

var bonus_slots: Array[InventoryBonusSlot] = []

@export var slots_amount: int = 18
@onready var bonus_grid: GridContainer = $BonusSlots/MarginContainer/BonusGrid

func _ready() -> void:
	for slots in bonus_grid.get_children():
		bonus_slots.push_back(slots)
	
	for i in slots_amount:
		create_slot()
	
	if bonus_slots.size() > 0:
		var slot_child: InventoryBonusSlot = bonus_slots[0]
		var grid_width = bonus_grid.get_parent().size.x
		print("grid_scale.x %d / slot_size %d" % [grid_width, slot_child.size.y])
		var grid_column_size = floor(grid_width / slot_child.size.y)
		print("grid count: %d" % grid_column_size)
		bonus_grid.columns = grid_column_size
		
func create_slot():
	var slot_scene: PackedScene = preload("res://scenes/ui/inventory/inventory_bonus_slot.tscn")
	var new_slot: Node =  slot_scene.instantiate()
	bonus_grid.add_child(new_slot)
	bonus_slots.push_back(new_slot)

func has_free_slots() -> bool:
	var found_free: bool = false
	
	for slot in bonus_slots:
		if !slot.has_weapon:
			found_free = true
			break
	
	return found_free
	
func get_free_slot() -> int:
	var free_slot_index: int = -1
		
	var i:int = 0
	for slot in bonus_slots:
		if !slot.has_weapon:
			free_slot_index = i
			break
			
		i = i + 1

	return free_slot_index
