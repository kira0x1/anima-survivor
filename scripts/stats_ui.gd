extends Panel

@onready var stamina_label: Label = %stamina_label
@onready var speed_label: Label = %speed_label
@onready var xp_bar: ProgressBar = $bio/xp_bar

func _ready() -> void:
	var stats = %Player.stats
	stamina_label.text = "stamina: %d" % stats.stamina
	speed_label.text = "speed: %d" % stats.speed
	xp_bar.refresh_ui(stats.xp, stats.max_xp)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stats_ui"):
		toggle_ui()

func toggle_ui() -> void:
	visible = !visible


func _on_player_on_xp_change() -> void:
	xp_bar.refresh_ui(%Player.stats.xp, %Player.stats.max_xp)
