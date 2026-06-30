extends Label

var state_machine
var in_chase_state
var current_state

func _ready() -> void:
	state_machine = %mob.get_node("state_machine")
	text = String(state_machine.current_state.get_name())

func _on_state_machine_state_changed(current_state: Variant) -> void:
	self.current_state = current_state
	in_chase_state = current_state.get_name() == "chase_state"
	update_text()

func update_text():
	text = String(current_state.get_name())
	
	if current_state.get_name() == "chase_state":
		text += "\n" + "player in distance: %s" % current_state.player_in_min_distance
		text += "\n" + "distance: %d / %d" % [current_state.MIN_CHASE_DISTANCE, current_state.player_distance]
				
		if not current_state.player_in_min_distance and current_state.chase_timer:
			text += "\nTimer: %d" % current_state.chase_timer.time_left
		
func _process(_delta: float) -> void:
	if in_chase_state:
		update_text()
