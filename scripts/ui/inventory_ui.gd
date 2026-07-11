extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		toggle_ui()

func toggle_ui() -> void:
	visible = !visible