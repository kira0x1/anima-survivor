extends Control

class_name UpgradeCard

signal upgrade_clicked(upgrade_card: UpgradeCard, upgrade)

@onready var description_text: Label = $"Text Panel/Description Text"
@onready var name_text: Label = $"Name Text"
@onready var icon_btn: Button  = $"Upgrade Icon"

var upgrade_data: Variant
var upgrade_type: UpgradeSelection.UpgradeType = UpgradeSelection.UpgradeType.STAT

func init_card(upgrade, card_type: UpgradeSelection.UpgradeType):
	if card_type == UpgradeSelection.UpgradeType.WEAPON:
		init_weapon_card(upgrade)
	else:
		init_stat_card(upgrade)
	
	upgrade_type = card_type

func init_stat_card(upgrade: UpgradeData):
	icon_btn.icon = upgrade.upgrade_icon
	name_text.text = upgrade.upgrade_name
	description_text.text = upgrade.upgrade_description
	upgrade_data = upgrade

func init_weapon_card(weapon: WeaponData):
	icon_btn.icon = weapon.weapon_icon
	name_text.text = weapon.weapon_name
	description_text.text = weapon.weapon_description
	upgrade_data = weapon

func _on_accept_button_pressed() -> void:
	upgrade_clicked.emit(self, upgrade_data)
