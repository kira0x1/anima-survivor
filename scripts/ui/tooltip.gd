extends RichTextLabel

class_name Tooltip

func show_text(content: String):
	text = content
	visible = true

func hide_text():
	text = ""
	visible = false;
