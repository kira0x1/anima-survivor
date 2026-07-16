extends Panel

class_name InventoryWeaponCard

@onready var name_text: RichTextLabel = $NameText
@onready var description_text: Label = $"Text Panel/MarginContainer/Description Text"
@onready var icon_btn: Button  = $"Weapon Icon"

var has_weapon: bool = false
var weapon_data: WeaponData
	
func set_weapon(weapon: WeaponData):
	weapon_data = weapon
	icon_btn.icon = weapon.icon
	name_text.text = weapon.name
	description_text.text = weapon.description
	has_weapon = true
