extends ProgressBar

@onready var label: Label = get_node("health_text") 

func _ready() -> void:
	refresh_ui()

func refresh_ui():
	value = %Player.health
	label.text = "%d / %d" % [%Player.health, %Player.max_health]
	
func _on_player_on_damage() -> void:
	refresh_ui()	
