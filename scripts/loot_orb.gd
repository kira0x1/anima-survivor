extends Area2D

class_name LootOrb

var is_consumed: bool = false
var is_grabbed: bool = false
@onready var player = get_node("/root/Game/Player")

const MIN_CONSUME_DISTANCE: float = 30.0
const MOVE_SPEED: float = 100.0

func _physics_process(delta: float) -> void:
	if !is_grabbed or is_consumed:
		return
	
	var player_pos = player.global_position
	global_position = global_position.move_toward(player_pos, MOVE_SPEED * delta)
	
	var distance: float = global_position.distance_to(player_pos)
	if distance < MIN_CONSUME_DISTANCE:
		consume()

func consume():
	is_consumed = true
	give_consume_award()
	queue_free()

func give_consume_award():
	pass
	
func _on_body_entered(_body: Node2D) -> void:
	if !is_consumed and !is_grabbed:
		is_grabbed = true
