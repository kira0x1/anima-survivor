extends Panel

@onready var stamina_label: RichTextLabel = %stamina_label
@onready var speed_label: RichTextLabel = %speed_label
@onready var weapon_range_label: RichTextLabel = %weapon_range

@onready var xp_bar: ProgressBar = $bio/xp_bar
@onready var level_label: Label = $bio/info/level_label
@onready var stats: Stats = %Player.stats

func _ready() -> void:
	refresh_stat_ui()

func refresh_stat_ui():
	if stats.stamina_bonus > 0.0: speed_label.text = "stamina: [color=#25B55A]%d[/color]" % stats.total_stamina
	else: stamina_label.text = "stamina: %d" % stats.stamina

	if stats.speed_bonus > 0.0: speed_label.text = "speed: [color=#25B55A]%d[/color] (%d)" % [stats.total_speed, stats.calculate_velocity()]
	else: speed_label.text = "speed: %d (%d)" % [stats.total_speed, stats.calculate_velocity()]

	if stats.weapon_range_bonus > 0.0: weapon_range_label.text = "range: [color=#25B55A]%d[/color]" % stats.weapon_range_bonus
	else: weapon_range_label.text = "range: %d" % stats.weapon_range_bonus

	xp_bar.refresh_ui(stats.xp, stats.max_xp)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stats_ui"):
		toggle_ui()

func toggle_ui() -> void:
	refresh_stat_ui()
	visible = ! visible

func _on_player_on_xp_change() -> void:
	xp_bar.refresh_ui(%Player.stats.xp, %Player.stats.max_xp)

func _on_player_on_level_up() -> void:
	level_label.text = "lvl %d" % %Player.stats.level

func _on_player_gained_stat_upgrade(_stat_upgrade: UpgradeData) -> void:
	refresh_stat_ui()
	print("stat speed: %d" % stats.speed)
