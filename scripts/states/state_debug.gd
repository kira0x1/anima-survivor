extends Label

func _on_StateMachine_state_changed(current_state):
	text = String(current_state.get_name())