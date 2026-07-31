extends Panel
class_name InventoryWeaponCard

@onready var name_text: RichTextLabel = $TopPanel/GridContainer/NamePanel/MarginContainer/NameText
@onready var description_text: RichTextLabel = $TextPanel/MarginContainer/DescriptionText
@onready var icon_btn: Button = $TopPanel/GridContainer/WeaponIcon

var has_weapon: bool = false
var weapon: Weapon
var weapon_data: WeaponData

func set_weapon(weapon_spawned: Weapon):
	weapon = weapon_spawned
	weapon_data = weapon.weapon_data

	icon_btn.icon = weapon_data.icon
	name_text.text = weapon_data.name

	update_weapon_stats()

	has_weapon = true


func update_weapon_stats():
	var attack_speed_text: String = "Attack Speed: %0.2f [color=#25B55A](%0.2f)[/color]" % [weapon.attack_speed, weapon.final_attack_speed]
	var desc: String = "[i]%s[/i]\n%s" % [weapon_data.description, attack_speed_text]
	description_text.text = desc
	
	
