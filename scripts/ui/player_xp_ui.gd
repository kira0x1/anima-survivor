extends Control

@onready var level_text: Label = $level_label
@onready var xp_bar: ProgressBar = $xp_bar
@onready var xp_text: Label = $xp_bar/Label

func refresh_ui():
	level_text.text = "level %d" % %Player.stats.level
	xp_bar.refresh_ui(%Player.stats.xp, %Player.stats.max_xp)

func _on_player_on_xp_change() -> void:
	refresh_ui()

func _on_player_on_level_up() -> void:
	refresh_ui()
