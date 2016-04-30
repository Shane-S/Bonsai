
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input_event(viewport, evt, shape_idx):
	if(evt.type == InputEvent.MOUSE_BUTTON):
		print("bar")
		get_tree().set_input_as_handled ( )


