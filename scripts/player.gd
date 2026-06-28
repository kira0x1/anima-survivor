extends CharacterBody2D

@onready var player_anim: AnimatedSprite2D = $Colorizer/Sprite
var lastDirection: Vector2 = Vector2(0,0);
var direction: Vector2 = Vector2(0,0);

func _physics_process(delta: float) -> void:
	velocity = direction * 100;
	move_and_slide()

func _process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player_anim.move(velocity)