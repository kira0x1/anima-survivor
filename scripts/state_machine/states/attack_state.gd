extends State

var attack_timer: Timer
var is_active: bool = false
var is_attacking: bool = false
var in_attack_range: bool = false

# todo: remove when done testing
var player_distance: float = 0.0

const ATTACK_DAMAGE: float = 10.0 
const ATTACK_SPEED: float = 1.0
const ATTACK_DISTANCE: float = 60.0

@onready var anim: AnimatedSprite2D = owner.get_node(^"sprite") 
var player

func _ready() -> void:
	attack_timer = owner.get_node(^"attack_timer")
	player = get_node("/root/Game/Player")

func enter():
	is_active = true
	is_attacking = false
	attack_timer.wait_time = ATTACK_SPEED
	attack_timer.start()
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
	player_distance = distance
	
	in_attack_range = distance < ATTACK_DISTANCE;

	if not in_attack_range and not is_attacking:
		finished.emit("chase")


func _on_attack_timer_timeout() -> void:
	attack()

func _on_sprite_animation_finished() -> void:
	if is_attacking and is_active:
		if in_attack_range:
			player.take_damage(ATTACK_DAMAGE)

		anim.play("idle")
		is_attacking = false
		attack_timer.start()
