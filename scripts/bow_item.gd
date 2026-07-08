extends Area2D

@export var fire_rate: float = 0.8;
@export var damage: float = 10.0;

var has_target: bool = false

func _ready() -> void:
	var timer: Timer = %Timer
	timer.wait_time = fire_rate
	
func _physics_process(_delta: float) -> void:
	var bodies: Array[Node2D] = get_overlapping_bodies()
	has_target = bodies.size() > 0
	
	if bodies.size() > 0:
		var target: Node2D = bodies[0]
		look_at(target.global_position)
		
		
func shoot():
	const ARROW: PackedScene = preload("res://scenes/arrow.tscn")
	var new_arrow: Node = ARROW.instantiate()
	new_arrow.global_position = %ShootingPoint.global_position
	new_arrow.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_arrow)


func _on_timer_timeout() -> void:
	if has_target:
		shoot()
