extends Control

@onready var weapon_inventory: WeaponInventoryPanel = $MainPanel/WeaponPanel
@onready var bonus_inventory: BonusInventoryPanel = $MainPanel/SlotPanels/BonusPanel
@onready var item_inventory: ItemsInventoryPanel = $MainPanel/SlotPanels/ItemsPanel

signal inventory_toggled(showing: bool)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		toggle_ui()

func toggle_ui() -> void:
	visible = ! visible
	inventory_toggled.emit(visible)
	weapon_inventory.refresh_weapons()

func _on_player_gained_stat_upgrade(stat_upgrade: UpgradeData) -> void:
	bonus_inventory.on_player_gained_bonus(stat_upgrade)

# TODO: on player gained item

func _on_hand_equip_spawned_weapon(weapon: Weapon) -> void:
	weapon_inventory.on_player_gained_weapon(weapon)
