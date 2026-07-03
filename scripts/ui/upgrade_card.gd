extends Control

class_name UpgradeCard

@onready var description_text: Label = $"Text Panel/Description Text"
@onready var name_text: Label = $"Name Text"
@onready var icon_btn: Button  = $"Upgrade Icon"

func init_card(upgrade: UpgradeData):
	icon_btn.icon = upgrade.upgrade_icon
	name_text.text = upgrade.upgrade_name
	description_text.text = description_text.text
