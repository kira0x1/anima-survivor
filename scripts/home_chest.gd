extends Node2D

func _on_chest_area_body_entered(body: Node2D) -> void:
	print("%s entered chest area" % body.name)
