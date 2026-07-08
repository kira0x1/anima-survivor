extends Area2D

const SPEED: int = 760
const RANGE: int = 1200
const BULLET_DAMAGE: int = 5

var travel_distance: int = 0

func _physics_process(delta):
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travel_distance += SPEED * delta;
	if travel_distance > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(BULLET_DAMAGE)