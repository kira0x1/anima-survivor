extends State

var is_active

func enter():
	is_active = true
	owner.get_node(^"sprite").play("dead")
	print("entered death state")

func exit():
	print("exiting death state")
	is_active = false
