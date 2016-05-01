
extends Container

const GAME_SCENE = "res://scenes/game_scene.tscn"

func _ready():
	set_process(true)
	pass

func _on_play_button_pressed():
	get_node("/root/global").transition(GAME_SCENE)	
	pass