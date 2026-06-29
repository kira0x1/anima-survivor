extends State  

var is_active;

func enter():
	is_active = true
	print("entered chase state")
	
func exit():
	is_active = false

func _physics_process(_delta: float) -> void:
	if is_active:
		owner.chase_player()