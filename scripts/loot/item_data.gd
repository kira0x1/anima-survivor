class_name ItemData extends Resource

@export var name: String
@export var icon: Texture
@export var description: String

@export var stackable: bool = false
@export var max_stack: int = 16

@export var item_scene: PackedScene

enum ItemType {
	CONSUMABLE,
	WEAPON,
	RELIC
}

@export var item_type: ItemType = ItemType.CONSUMABLE