extends Area2D

# dont shoot if enemies this close
const MIN_RANGE: float = 40.0

@export var fire_rate: float = 0.8;
@export var damage: float = 10.0;

var has_target: bool = false
var target: Mob

func _ready() -> void:
	var timer: Timer = %Timer
	timer.wait_time = fire_rate
	
func filter_targets(bodies: Array[Node2D]) -> void:
	has_target = false

	if bodies.size() == 0:
		return

	for body in bodies:
		var t: Mob = body

		if t.is_dead:
			continue

		has_target = true
		target = t
		break
	

func _physics_process(_delta: float) -> void:
	var bodies: Array[Node2D] = get_overlapping_bodies()

	filter_targets(bodies)
	
	if has_target:
		look_at(target.global_position)
			
		
func shoot() -> void:
	var target_distance: float = target.get_player_distance()
	if target_distance <= MIN_RANGE:
		print("too close so not shooting")
		return
	
	const ARROW: PackedScene = preload("res://scenes/arrow.tscn")
	var new_arrow: Node = ARROW.instantiate()
	new_arrow.global_position = %ShootingPoint.global_position
	new_arrow.global_rotation = %ShootingPoint.global_rotation
	new_arrow.damage = damage	
	%ShootingPoint.add_child(new_arrow)


func _on_timer_timeout() -> void:
	if has_target:
		shoot()
