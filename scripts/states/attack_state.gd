extends State

var is_active
var attack_timer: Timer
const ATTACK_SPEED: float = 1.0
const ATTACK_DISTANCE: float = 80.0
var is_attacking
@onready var anim: AnimatedSprite2D = owner.get_node(^"sprite") 

func enter():
	is_active = true
	attack_timer = owner.get_node(^"attack_timer")
	attack_timer.wait_time = ATTACK_SPEED
	attack()
	print("entered attack state")
	

func attack():
	is_attacking = true
	anim.play("attack")

func exit():
	is_active = false
	attack_timer.stop()

func _physics_process(_delta: float) -> void:
	if not is_active:
		return
	
	var distance = owner.get_player_distance()
	
	if distance > ATTACK_DISTANCE:
		finished.emit("chase")	


func _on_attack_timer_timeout() -> void:
	attack()


func _on_sprite_animation_finished() -> void:
	if is_attacking and is_active:
		anim.play("idle")
		is_attacking = false
		attack_timer.start()
