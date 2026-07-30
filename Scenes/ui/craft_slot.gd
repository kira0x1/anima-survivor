extends TextureButton

class_name CraftSlot

@onready var item_icon: TextureRect = $ItemIcon

var is_occupied: bool = false

func set_item(item_data: ItemData):
	is_occupied = true
	item_icon.texture = item_data.icon
	item_icon.visible = true

func remove_item():
	is_occupied = false
	item_icon.visible = false
