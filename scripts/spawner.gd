extends Node2D

signal on_mob_spawned

# can disable spawning mobs from spawning_manager
var is_spawning_mobs: bool = true

var min_spawn_rate: float = 0.2
var max_spawn_rate: float = 0.3
var spawn_rate: float = 0.2;

const MAX_MOBS_ALIVE: int = 10
var mobs_spawned_count: int = 0
var spawn_points: Array[Variant] = []
@onready var timer: Timer = get_node("Timer") 

func _ready() -> void:
	spawn_points = find_children("spawn_*")
	timer.wait_time = spawn_rate
	timer.start()

func _on_timer_timeout() -> void:
	spawn_rate = randf_range(min_spawn_rate, max_spawn_rate)
	timer.wait_time = spawn_rate
	timer.start()
		
	if is_spawning_mobs and mobs_spawned_count <= MAX_MOBS_ALIVE:
		spawn_mob()

func spawn_mob():
	var spawn_picked = spawn_points.pick_random()
	const mob_prefab: PackedScene = preload("res://scenes/mob.tscn")
	var mob: Mob = mob_prefab.instantiate()
	spawn_picked.add_child(mob)
	mob.on_death.connect(mob_died)
	mob.global_position = spawn_picked.global_position	
	on_mob_spawned.emit()
	mobs_spawned_count = mobs_spawned_count + 1
	
func mob_died(_mob: Mob):
	mobs_spawned_count = mobs_spawned_count - 1
	pass