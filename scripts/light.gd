
extends Node2D

signal light_turned_on
signal light_turned_off
signal light_changed

export(bool) var enabled = false
export(float) var disabled_light_mod = 0.0
export(float) var enabled_light_mod = 3.0

const DISABLED_MODULATE_COLOR = Color(0.14, 0.14, 0.33, 1.0)
const ENABLED_MODULATE_COLOR = Color(1.0, 1.0, 1.0, 1.0)

onready var sprite = get_node("Sprite")

func _ready():
	if enabled:
		turn_on()
	else:
		turn_off()

func current_light_mod():
	if enabled:
		return enabled_light_mod
	else:
		return disabled_light_mod

func turn_on():
	enabled = true
	sprite.set_modulate(ENABLED_MODULATE_COLOR)
	emit_signal("light_turned_on")
	emit_signal("light_changed")
	
func turn_off():
	enabled = false
	sprite.set_modulate(DISABLED_MODULATE_COLOR)
	emit_signal("light_turned_off")
	emit_signal("light_changed")


func _on_Panel_input_event( evt ):
	if (evt.type == InputEvent.MOUSE_BUTTON and not evt.is_pressed()):
		if enabled:
			turn_off()
		else:
			turn_on()
