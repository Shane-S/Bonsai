
extends Panel

# member variables here, example:
# var a=2# var b="textvar"

func _ready():
	set_process_input(true)
	pass
	
func _input(evt):
	if(evt.type == InputEvent.MOUSE_BUTTON):
		print("bar")
		get_tree().set_input_as_handled ( )