extends CharacterBody2D

@onready var anim: Node = get_node("sprite")
@onready var aggro_detector: Area2D = get_node("aggro_radius")
var move_speed: float = 60.0

func chase_player():
	var player_pos = %Player.global_position
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
	var player_pos = %Player.global_position
	var distance: float = global_position.distance_to(player_pos)
	return distance

func get_player_direction() -> Vector2:
	var player_direction: Vector2 = to_local(%Player.global_transform.origin).normalized()
	return player_direction
