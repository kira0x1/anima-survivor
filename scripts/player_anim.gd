extends AnimatedSprite2D
var lastDirection: Vector2 = Vector2(0,0);

func move(direction: Vector2) -> void:

	if direction.x > 0.0:
		play("walk_right")
		flip_h = false
	elif direction.x < 0.0:
		play("walk_right")
		flip_h = true
	elif direction.y < 0.0:
		play("walk_up")
		flip_v = false;
	elif direction.y > 0.0:
		play("walk_down")
	
	if direction.length() < 0.01 && lastDirection.length() > 0.0:
			set_idle_anim()
		
	lastDirection = direction

func set_idle_anim():
	if lastDirection.x > 0.0:
		flip_h = false
		play("idle_right")
	elif lastDirection.x < 0.0:
		flip_h = true
		play("idle_right")
	elif lastDirection.y < 0.0:
		play("idle_up")
	else:
		play("idle")
