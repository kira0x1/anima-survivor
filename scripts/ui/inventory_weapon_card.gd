extends Panel

class_name InventoryWeaponCard

@onready var description_text: Label = $"Text Panel/Description Text"
@onready var name_text: Label = $"Name Text"
@onready var icon_btn: Button  = $"Weapon Icon"

var has_weapon: bool = false
var weapon_data: WeaponData
	
func set_weapon(weapon: WeaponData):
	weapon_data = weapon
	icon_btn.icon = weapon.icon
	name_text.text = weapon.name
	description_text.text = weapon.description
	has_weapon = true
