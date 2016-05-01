
extends Panel

var initials = ""

signal ok_pressed

func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_released")

func _on_Button_released():
	print("foo")
	initials = get_node("LineEdit").get_text()
	emit_signal("ok_pressed")
