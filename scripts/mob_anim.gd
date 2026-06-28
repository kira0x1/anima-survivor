extends AnimatedSprite2D

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