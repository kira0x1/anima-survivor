extends Resource

class_name PlayerCharacter

@export var character_name: String = "character"
@export var character_bio: String = "backstory.."
@export var character_description: String = "combat descriptors"

@export var starting_weapon: WeaponData

@export_category("stats")
@export var speed: float = 10
@export var stamina: float = 1