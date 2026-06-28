extends Node2D

const spawn_rate: float = 0.7;

func _ready() -> void:
	var timer: Timer = get_node("Timer")
	timer.wait_time = spawn_rate
	timer.start()
	print("timer started...")


func _on_timer_timeout() -> void:
	spawn_mob()


func spawn_mob():
	pass
