extends Resource

class_name WeaponData

@export var name: String
@export var description: String
@export var icon: Texture2D

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