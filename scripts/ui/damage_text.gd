extends Marker2D

class_name DamageText

var move_speed: float = 60.0
var move_distance: float = 30.0
var start_shrink_time: float = 0.3
var shrink_speed: float = 3.5

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _process(delta: float) -> void:
	if timer.time_left <= start_shrink_time:
		var next_scale: Vector2 =  lerp(global_scale, Vector2.ZERO, shrink_speed * delta)
		global_scale = next_scale
	
	var y: float = global_position.y
	y -= move_speed * delta
	global_position.y = y

func set_damage(damage: float):
	label.text = "-%d" % damage

func _on_timer_timeout() -> void:
	queue_free()
