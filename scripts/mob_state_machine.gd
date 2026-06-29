extends StateMachine

@onready var idle = %idle_state
@onready var chase = %chase_state
#@onready var stagger = $stagger
#@onready var attack = $attack

func _ready() -> void:
	states_map = {
		"idle": idle,
		"chase": chase,
#		"attack": attack,
#		"stagger": stagger
	}
	
func _change_state(state_name):
	if not _active:
		return
	
#	if state_name in  ["stagger", "attack"]:
	states_stack.push_front(states_map[state_name])
	
	super._change_state(state_name)