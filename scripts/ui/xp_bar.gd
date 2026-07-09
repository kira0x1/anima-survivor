extends ProgressBar

@onready var xp_text: Label = $Label

func refresh_ui(xp: float, max_xp: float = 100.0):
	value = xp
	max_value = max_xp
	xp_text.text = "%0.0f / %0.0f" % [xp, max_xp]