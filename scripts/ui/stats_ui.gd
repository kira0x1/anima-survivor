extends Panel

# editor 
@export_group("Style")
@export var title_font_size: int = 18
@export_group("Style")
@export var stat_font_size: int = 16
@export_group("Style")
@export var stat_gap: int = 2

@onready var stamina_label: RichTextLabel = %stamina_label
@onready var speed_label: RichTextLabel = %speed_label
@onready var range_label: RichTextLabel = %range_label

@onready var weapon_range_label: RichTextLabel = %weapon_range
@onready var attack_speed_label: RichTextLabel = %attack_speed

@onready var xp_bar: ProgressBar = $bio/xp_bar
@onready var level_label: Label = $bio/info/level_label
@onready var stats: Stats = %Player.stats

func _ready() -> void:
	refresh_stat_ui()
	_update_ui_style()

func _update_ui_style():
	var character_panel: Panel = $stats/Character_Panel
	var weapon_panel: Panel = $stats/Weapon_Panel

	var c_stats_grid: VBoxContainer = $stats/Character_Panel/Character_Stats
	var w_stats_grid: VBoxContainer = $stats/Weapon_Panel/Weapon_Stats
	c_stats_grid.add_theme_constant_override("separation", stat_gap)
	w_stats_grid.add_theme_constant_override("separation", stat_gap)
	# weapon_panel.offset_top = 35;

	var weapon_title: Label = $stats/Weapon_Panel/Weapon_Label
	var character_title: Label = $stats/Character_Panel/Character_Label
	weapon_title.offset_top = weapon_panel.offset_top;
	character_title.offset_top = character_panel.offset_top;

	var titles: Array[Label] = [weapon_title, character_title]
	character_title.add_theme_font_size_override("font_size", title_font_size)
	weapon_title.add_theme_font_size_override("font_size", title_font_size)

	for t in titles:
		t.offset_bottom = 0;
		t.offset_top = -(title_font_size + 9);

	# print("offset: %f" % weapon_title.offset_top)

	# get character / weapon labels
	var c_labels: Array[Node] = character_panel.find_children("", "RichTextLabel", true, true)
	var w_labels: Array[Node] = weapon_panel.find_children("", "RichTextLabel", true, true)
	var labels: Array[RichTextLabel] = []
	labels.append_array(c_labels)
	labels.append_array(w_labels)

	for l in labels:
		l.add_theme_font_size_override("normal_font_size", stat_font_size)

func _print_labels(labels):
	print("labels found %d" % labels.size())
	for l in labels:
		print(l.name)

func refresh_stat_ui():
	if stats.character_range_bonus > 0.0: range_label.text = "range: [color=#25B55A]%d[/color]" % stats.character_total_range
	else: range_label.text = "range: %d" % stats.character_range_bonus

	if stats.stamina_bonus > 0.0: speed_label.text = "stamina: [color=#25B55A]%d[/color]" % stats.total_stamina
	else: stamina_label.text = "stamina: %d" % stats.stamina

	if stats.speed_bonus > 0.0: speed_label.text = "speed: [color=#25B55A]%d[/color] (%d)" % [stats.total_speed, stats.calculate_velocity()]
	else: speed_label.text = "speed: %d (%d)" % [stats.total_speed, stats.calculate_velocity()]

	if stats.weapon_range_bonus > 0.0: weapon_range_label.text = "range: [color=#25B55A]%d[/color]" % stats.weapon_range_bonus
	else: weapon_range_label.text = "range: %d" % stats.weapon_range_bonus

	if stats.attack_speed_bonus > 0.0: attack_speed_label.text = "atkspd: [color=#25B55A]%d[/color]" % stats.attack_speed_bonus
	else: attack_speed_label.text = "atkspd: %d" % stats.attack_speed_bonus

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

func _on_inventory_ui_inventory_toggled(showing: bool) -> void:
	visible = ! showing
