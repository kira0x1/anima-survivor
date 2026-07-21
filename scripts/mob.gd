extends CharacterBody2D

class_name Mob

signal on_damage
signal on_death(mob: Mob)

@onready var anim: Node = get_node("sprite")
@onready var aggro_detector: Area2D = $"aggro_radius"
@onready var loot_table: LootTable = $loot_table
@onready var death_despawn_timer: Timer = $despawn_timer

@export var attack_damage: float = 20.0

var move_speed: float = 60.0
var player

var health: float = 100.0;
var max_health: float = 100.0;
var is_dead: bool = false;

func _ready() -> void:
	player = get_tree().root.get_node("Game/Player")
	%attack_state.attack_damage = attack_damage

func chase_player() -> void:
	if is_dead or not is_node_ready():
		return

	var player_pos = player.global_position
	var dir_to_player: Vector2 = get_player_direction()
	
	if dir_to_player.x > 0.0:
		anim.flip_h = true
	elif dir_to_player.x < 0.0:
		anim.flip_h = false

	var direction: Vector2 = global_position.direction_to(player_pos)
	velocity = direction * move_speed
	move_and_slide()

	anim.handle_velocity(velocity);

func get_player_distance() -> float:
	var player_pos = player.global_position
	var distance: float = global_position.distance_to(player_pos)
	return distance

func get_player_direction() -> Vector2:
	var player_direction: Vector2 = to_local(player.global_transform.origin).normalized()
	return player_direction

func take_damage(damage_info: DamageInfo) -> void:
	if is_dead:
		return
		
	health -= damage_info.damage;
	if health <= 0.0:
		health = 0.0;
		handle_death()
	
	create_damage_text(damage_info)
	on_damage.emit()

func create_damage_text(damage_info: DamageInfo):
	const damage_text_scene: PackedScene = preload("res://scenes/ui/damage_numbers.tscn"	)
	var damage_text: DamageText = damage_text_scene.instantiate()
	get_tree().root.get_node("Game").add_child(damage_text)
	var spawn_pos: Vector2 = global_position
	spawn_pos.y += 10.0
	damage_text.global_position = spawn_pos
	damage_text.set_damage(damage_info)

func handle_death():
	is_dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	loot_table.spawn_item()
	on_death.emit(self)
	$despawn_timer.start()

func _on_despawn_timer_timeout() -> void:
	queue_free()