extends Resource

class_name WeaponData

@export var name: String
@export var description: String
@export var icon: Texture2D

@export var weapon_type: WeaponType
@export var range_type: RangeType
@export var base_range: float = 100.0
@export var base_firerate: float = 0.8

@export var item_scene: PackedScene

enum WeaponType {
	SWORD,
	AXE,
	KATANA,
	DAGGER,
	
	PISTOL,
	RIFLE,
	BOW,
	BOOMERANG
}

enum RangeType {
	MELEE,
	RANGED
}
