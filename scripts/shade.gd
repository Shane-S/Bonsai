
extends Node2D

signal shade_opened
signal shade_closed
signal shade_changed

export(bool) var is_open = false
export(int) var open_sun_mod = -3
export(int) var closed_sun_mod = 0
onready var open_sprite = get_node("OpenSprite")
onready var closed_sprite = get_node("ClosedSprite")

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
	is_open = true
	open_sprite.show()
	closed_sprite.hide()
	emit_signal("shade_opened")
	emit_signal("shade_changed")
	
func close():
	is_open = false
	open_sprite.hide()
	closed_sprite.show()
	emit_signal("shade_closed")
	emit_signal("shade_changed")


func _on_Panel_input_event( evt ):
	if (evt.type == InputEvent.MOUSE_BUTTON and not evt.is_pressed()):
		if is_open:
			close()
		else:
			open()
