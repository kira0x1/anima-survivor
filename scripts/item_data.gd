extends Resource

class_name ItemData

@export var item_name: String
@export var item_description: String
@export var stackable: bool = false
@export var max_stack: int = 16

@export var icon: Texture
@export var item_scene: PackedScene