extends Area2D

class_name LootOrb

var can_consume: bool = false
var is_grabbed: bool = false
var is_consumed: bool = false

const MIN_CONSUME_DISTANCE: float = 30.0
const MOVE_SPEED: float = 200.0

@onready var player: Player = get_node("/root/Game/Player")

func _ready() -> void:
	can_consume = true

func _physics_process(delta: float) -> void:
	if !is_grabbed or !can_consume:
		return
	
	var player_pos: Vector2 = player.global_position
	global_position = global_position.move_toward(player_pos, MOVE_SPEED * delta)
	
	var distance: float = global_position.distance_to(player_pos)

	if distance < MIN_CONSUME_DISTANCE:
		consume()

func consume() -> bool:
	if !can_consume: 
		return false

	is_consumed = true
	can_consume = false
	give_consume_award()
	queue_free()
	return true

func give_consume_award():
	pass
	
func _on_body_entered(_body: Node2D) -> void:
	if can_consume and !is_grabbed:
		is_grabbed = true
