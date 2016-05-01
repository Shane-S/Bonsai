
extends Node2D

signal shade_opened
signal shade_closed
signal shade_changed

export(bool) var is_open = false
export(int) var open_sun_mod = -3
export(int) var closed_sun_mod = 0
onready var animation = get_node("BaseSprite/TopSprite/AnimationPlayer")

func _ready():
	if is_open:
		open()
	else:
		close()

func current_light_mod():
	if is_open:
		return open_sun_mod
	else:
		return closed_sun_mod

func open():
	if not is_open:
		is_open = true
		animation.play("open")
		emit_signal("shade_changed")
	emit_signal("shade_opened")
	
func close():
	if is_open:
		is_open = false
		animation.play("close")
		emit_signal("shade_changed")
	emit_signal("shade_closed")
	


func _on_Panel_input_event( evt ):
	if (evt.type == InputEvent.MOUSE_BUTTON and not evt.is_pressed()):
		if is_open:
			close()
		else:
			open()
