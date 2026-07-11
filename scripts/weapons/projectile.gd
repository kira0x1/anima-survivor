extends Area2D

const SPEED: int = 760
const RANGE: int = 1200
var damage: float = 5.0

var has_hit
var travel_distance: int = 0

func _physics_process(delta) -> void:
	if has_hit:
		return
		
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travel_distance += SPEED * delta;
	if travel_distance > RANGE:
		has_hit = true
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if has_hit:
		return
		
	has_hit = true
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	queue_free()