extends Panel

@onready var stamina_label: Label = %stamina_label
@onready var speed_label: Label = %speed_label
@onready var xp_bar: ProgressBar = $bio/xp_bar
@onready var level_label: Label = $bio/info/level_label
@onready var stats: Stats = %Player.stats 

func _ready() -> void:
	refresh_stat_ui()
	
func refresh_stat_ui():
	stamina_label.text = "stamina: %d" % stats.stamina
	speed_label.text = "speed: %d (%d)" % [stats.speed, stats.calculate_velocity()]
	xp_bar.refresh_ui(stats.xp, stats.max_xp)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stats_ui"):
		toggle_ui()

func toggle_ui() -> void:
	visible = !visible

func _on_player_on_xp_change() -> void:
	xp_bar.refresh_ui(%Player.stats.xp, %Player.stats.max_xp)

func _on_player_on_level_up() -> void:
	level_label.text = "lvl %d" % %Player.stats.level

func _on_player_on_stat_change() -> void:
	refresh_stat_ui()
	print("stat speed: %d" % stats.speed)
