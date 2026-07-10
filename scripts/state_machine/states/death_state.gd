extends State

var is_active

func enter():
	is_active = true
	owner.get_node(^"sprite").play("dead")

func exit():
	is_active = false
