
extends Node2D

signal watering_can_clicked

export(int) var water_amount = 3

func _on_Panel_input_event(evt):
	#emit the signal on mouse-up.
	#you can listen for the signal by using the connection editor
	if (evt.type == InputEvent.MOUSE_BUTTON and not evt.is_pressed()):
		get_node("Water/AnimationPlayer").play("water")
		emit_signal("watering_can_clicked")
	

