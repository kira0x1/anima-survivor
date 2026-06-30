extends State

var is_active
var attack_timer: Timer
var is_attacking

const ATTACK_DAMAGE: float = 10.0 
const ATTACK_SPEED: float = 0.2
const ATTACK_DISTANCE: float = 80.0

@onready var anim: AnimatedSprite2D = owner.get_node(^"sprite") 
var player

func _ready() -> void:
	attack_timer = owner.get_node(^"attack_timer")
	player = get_node("/root/Game/Player")

func enter():
	is_active = true
	is_attacking = false
	attack_timer.wait_time = ATTACK_SPEED
	attack()

func attack():
	if not is_attacking:
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
		player.take_damage(ATTACK_DAMAGE)
		anim.play("idle")
		is_attacking = false
		attack_timer.start()
