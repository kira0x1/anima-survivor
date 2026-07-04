extends Resource

class_name WeaponData

@export var weapon_name: String
@export var weapon_description: String
@export var weapon_icon: Texture2D

@export var weapon_type: WeaponType
@export var range_type: RangeType

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