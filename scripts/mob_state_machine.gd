extends StateMachine

@onready var idle: State = %idle_state
@onready var chase: State = %chase_state
@onready var attack: State = %attack_state
@onready var death: State = %death_state
#@onready var stagger = $stagger

func _ready() -> void:
	states_map = {
		"idle": idle,
		"chase": chase,
		"attack": attack,
		"death": death
#		"stagger": stagger
	}
	
func _change_state(state_name) -> void:
	if not _active:
		return
	
#	if state_name in  ["stagger", "attack"]:
	states_stack.push_front(states_map[state_name])
	
	super._change_state(state_name)

func _on_mob_on_death() -> void:
	_change_state("death")