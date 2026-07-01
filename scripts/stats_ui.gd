extends Panel

@onready var stamina_label: Label = %stamina_label
@onready var speed_label: Label = %speed_label

func _ready() -> void:
	stamina_label.text = "stamina: %d" % %Player.stats.stamina
	speed_label.text = "speed: %d" % %Player.stats.speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stats_ui"):
		toggle_ui()

func toggle_ui() -> void:
	visible = !visible
