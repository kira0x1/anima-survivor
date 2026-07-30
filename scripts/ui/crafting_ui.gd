extends Control

var craft_slots: Array[CraftSlot] = []
@onready var slot_container: FlowContainer = $Panel/FlowContainer

signal on_crafting_closed

func _ready() -> void:
	for slots in slot_container.get_children():
		craft_slots.push_back(slots)

func close_crafting():
	visible = false
	clear_grid()
	on_crafting_closed.emit()

func clear_grid():
	pass

func _on_close_button_pressed() -> void:
	close_crafting()
