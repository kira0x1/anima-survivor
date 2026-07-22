extends Panel

class_name InventoryWeaponCard

@onready var name_text: RichTextLabel = $TopPanel/GridContainer/NamePanel/MarginContainer/NameText
@onready var description_text: Label = $TextPanel/MarginContainer/DescriptionText
@onready var icon_btn: Button  = $TopPanel/GridContainer/WeaponIcon

var has_weapon: bool = false
var weapon_data: WeaponData
	
func set_weapon(weapon: WeaponData):
	weapon_data = weapon
	icon_btn.icon = weapon.icon
	name_text.text = weapon.name
	description_text.text = weapon.description
	has_weapon = true
	