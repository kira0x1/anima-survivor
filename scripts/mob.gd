extends CharacterBody2D

@onready var anim: Node = get_node("sprite")
@onready var aggro_detector: Area2D = get_node("aggro_radius")

var chase_state = "idle"
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


func _on_aggro_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player entered radius")