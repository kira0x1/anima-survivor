extends CharacterBody2D

@onready var anim: Node = get_node("sprite")
const max_distance: float = 49.0;

func _physics_process(_delta: float) -> void:
	var player_pos = %Player.global_position
	var distance: float = global_position.distance_to(player_pos)

	if distance > max_distance:
		var direction: Vector2 = global_position.direction_to(player_pos)
		velocity = direction * 40
		move_and_slide()
	else: 
		velocity = Vector2.ZERO
