extends Node2D

signal on_mob_spawned

# can disable spawning mobs from spawning_manager
var is_spawning_mobs: bool = true
const spawn_rate: float = 0.4;

var spawn_points: Array[Variant] = []

func _ready() -> void:
	var timer: Timer = get_node("Timer")
	spawn_points = find_children("spawn_*")
	timer.wait_time = spawn_rate
	timer.start()

func _on_timer_timeout() -> void:
	if is_spawning_mobs:
		spawn_mob()

func spawn_mob():
	var spawn_picked = spawn_points.pick_random()
	const mob_prefab: PackedScene = preload("res://scenes/mob.tscn")
	var mob: Mob = mob_prefab.instantiate()
	spawn_picked.add_child(mob)
	mob.on_death.connect(mob_died)
	mob.global_position = spawn_picked.global_position
	on_mob_spawned.emit()
	
func mob_died(_mob: Mob):
	pass