extends CharacterBody2D

@onready var anim: Node = get_node("sprite")
@onready var aggro_detector: Area2D = get_node("aggro_radius")

const max_distance: float = 49.0;

func chase_player():
	var player_pos = %Player.global_position
	var distance: float = global_position.distance_to(player_pos)

	if distance > max_distance:
		var direction: Vector2 = global_position.direction_to(player_pos)
		velocity = direction * 40
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	
	anim.handle_velocity(velocity);

func get_player_distance() -> float:
	var player_pos = %Player.global_position
	var distance: float = global_position.distance_to(player_pos)
	return distance
