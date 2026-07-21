extends Control

@onready var weapon_inventory: WeaponInventoryPanel = $MainPanel/WeaponPanel
@onready var bonus_inventory: BonusInventoryPanel = $MainPanel/BonusPanel

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		toggle_ui()

func toggle_ui() -> void:
	visible = !visible

func _on_player_gained_weapon(weapon_data: WeaponData) -> void:
	weapon_inventory.on_player_gained_weapon(weapon_data)

