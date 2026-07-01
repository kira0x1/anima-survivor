extends Panel

@onready var stamina_label: Label = %stamina_label
@onready var speed_label: Label = %speed_label

func _ready() -> void:
	stamina_label.text = "stamina: %d" % %Player.stats.stamina
	speed_label.text = "speed: %d" % %Player.stats.speed
