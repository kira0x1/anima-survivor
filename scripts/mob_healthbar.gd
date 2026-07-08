extends ProgressBar

@onready var mob: Mob = owner

func _ready() -> void:
	update_bar()

func update_bar():
	value = mob.health
	max_value = mob.max_health

func _on_mob_on_damage() -> void:
	update_bar()

func _on_mob_on_death(_mob: Mob) -> void:
	hide()	
