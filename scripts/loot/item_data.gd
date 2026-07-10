extends Resource

class_name ItemData

@export var name: String
@export var icon: Texture
@export var description: String

@export var stackable: bool = false
@export var max_stack: int = 16

@export var item_scene: PackedScene

enum ItemType {
	CONSUMABLE,
	WEAPON
}

@export var item_type: ItemType = ItemType.CONSUMABLE