extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Colorizer/Sprite
var lastDirection: Vector2 = Vector2(0,0);

func _process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction.x > 0.0:
		sprite.play("walk_right")
		sprite.flip_h = false
	if direction.x < 0.0:
		sprite.play("walk_right")
		sprite.flip_h = true
		
	if direction.y < 0.0:
		sprite.play("walk_up")
		sprite.flip_v = false;
	elif direction.y > 0.0:
		sprite.play("walk_down")
	
	if direction.length() < 0.01 && lastDirection.length() > 0.0:
			set_idle_anim()
		
	lastDirection = direction

func set_idle_anim():
	print(lastDirection)
	if lastDirection.x > 0.0:
		sprite.flip_h = false
		sprite.play("idle_right")
	elif lastDirection.x < 0.0:
		sprite.flip_h = true
		sprite.play("idle_right")
	elif lastDirection.y < 0.0:
		sprite.play("idle_up")
	else:
		sprite.play("idle")
