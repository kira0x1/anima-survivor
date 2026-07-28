extends Control

class_name Tooltip

@onready var label: RichTextLabel = $RichTextLabel

func show_text(text: String):
	label.text = text
	label.visible = true

func hide_text():
	label.text = ""
	label.visible = false;
