extends State

var is_active

func enter():
	is_active = true
	owner.get_node(^"sprite").play("idle")

func exit():
	is_active = false

func _on_aggro_radius_body_entered(_body: Node2D) -> void:
	if not is_active: 
		return
	
	finished.emit("chase")
	

func _on_mob_on_damage() -> void:
	if not is_active: 
		return
		
	finished.emit("chase")
