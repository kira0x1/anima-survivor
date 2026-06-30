extends State

var is_active

func enter():
	is_active = true
	owner.get_node(^"sprite").play("idle")
	print("entered idle state")

func exit():
	is_active = false
	print("exited idle state")

func _on_aggro_radius_body_entered(body: Node2D) -> void:
	if not is_active: 
		return
	
	print(body.name + " entered aggro radius")
	finished.emit("chase")
#	if body.is_in_group("player"):
	
