extends CharacterBody2D

signal on_damage
signal on_xp_change

@onready var player_anim: AnimatedSprite2D = $Colorizer/Sprite

var stats: Stats = Stats.new()
var health: float = 100.0;
var max_health: float = 100.0
var is_alive: bool = true

var lastDirection: Vector2 = Vector2(0,0);
var direction: Vector2 = Vector2(0,0);

func _physics_process(_delta: float) -> void:
	velocity = direction * 100;
	move_and_slide()

func _process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player_anim.move(velocity)

func take_damage(damage: float) -> void:
	if not is_alive:
		return

	health -= damage;
	
	if health <= 0.0:
		is_alive = false
		health = 0
		
	on_damage.emit()

func give_xp(xp: float):
	stats.xp += xp
	on_xp_change.emit()