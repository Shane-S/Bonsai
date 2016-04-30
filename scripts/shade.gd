
extends Node2D

signal shade_opened
signal shade_closed
signal shade_changed

export(bool) var is_open = false
export(int) var open_sun_mod = 0
export(int) var closed_sun_mod = -3
var sun_mod = closed_sun_mod
onready var open_sprite = get_node("OpenSprite")
onready var closed_sprite = get_node("ClosedSprite")

func _ready():
	if is_open:
		open()
	else:
		close()

func open():
	is_open = true
	sun_mod = open_sun_mod
	open_sprite.show()
	closed_sprite.hide()
	emit_signal("shade_opened")
	emit_signal("shade_changed")
	
func close():
	is_open = false
	sun_mod = closed_sun_mod
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
