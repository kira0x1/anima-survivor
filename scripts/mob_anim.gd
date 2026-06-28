extends AnimatedSprite2D

func handle_velocity(velocity: Vector2):
	if velocity.length() > 1:
		play_run()
	else:
		play_idle()

func play_idle():
	play("idle")
	
func play_run():
	play("run")
	
func play_hit():
	play("hit")

func play_dead():
	play("dead")

func play_attack():
	play("attack")