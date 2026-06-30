extends Label

var state_machine
var in_chase_state
var cur_state

func _ready() -> void:
	state_machine = %mob.get_node("state_machine")
	text = String(state_machine.current_state.get_name())

func _on_state_machine_state_changed(current_state: Variant) -> void:
	cur_state = current_state
	in_chase_state = current_state.get_name() == "chase_state"
	update_text()

func update_text():
	text = String(cur_state.get_name())
	
	if cur_state.get_name() == "chase_state":
		text += "\n" + "player in distance: %s" % cur_state.player_in_min_distance
		text += "\n" + "distance: %d / %d" % [cur_state.MIN_CHASE_DISTANCE, cur_state.player_distance]
				
		if not cur_state.player_in_min_distance and cur_state.chase_timer:
			text += "\nTimer: %d" % cur_state.chase_timer.time_left
		
func _process(_delta: float) -> void:
	if in_chase_state:
		update_text()
