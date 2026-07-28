extends Node2D

@onready var tooltip: Tooltip = %Tooltip
@onready var use_key = Input.get("action_use")
@onready var action_key: InputEventKey = InputMap.action_get_events("action_use")[0]
@onready var TOOLTIP_TEXT: String = "Press '%s' to use :3" % action_key.as_text_physical_keycode()

func _on_player_area_trigger_body_entered(_body: Node2D) -> void:
	tooltip.show_text(TOOLTIP_TEXT)


func _on_player_area_trigger_body_exited(_body: Node2D) -> void:
	tooltip.hide_text()
