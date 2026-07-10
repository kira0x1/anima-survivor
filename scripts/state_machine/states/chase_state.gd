extends State  

const MAX_CHASE_TIME: float = 3.0
const MAX_CHASE_DISTANCE: float = 400.0
const MIN_CHASE_DISTANCE: float = 100.0
var attack_distance: float = 100.0

var is_active
var body: CharacterBody2D
var chase_timer: Timer

var player_in_distance:bool
var player_distance: float = 0.0
var player_in_min_distance: bool

func _ready() -> void:
	attack_distance = %attack_state.ATTACK_DISTANCE

func enter():
	is_active = true
	body = owner
	chase_timer = owner.get_node(^"chase_timer")
	chase_timer.wait_time = MAX_CHASE_TIME
	
func exit():
	is_active = false
	chase_timer.stop()

func _physics_process(_delta: float) -> void:
	if not is_active:
		return

	owner.chase_player()
	var distance = owner.get_player_distance()
	
	player_distance = distance
	player_in_distance = distance <= MAX_CHASE_DISTANCE
	player_in_min_distance = distance >= MIN_CHASE_DISTANCE

	if distance < attack_distance:
		finished.emit("attack")

	if not player_in_distance and chase_timer.is_stopped():
		chase_timer.start()
	elif player_in_distance and not chase_timer.is_stopped():
		chase_timer.stop()

func _on_chase_timer_timeout() -> void:
	if is_active:
		if player_in_distance:
			chase_timer.stop()
		else:
			finished.emit("idle")
