
extends Node

const GAME_OVER_SCENE = "res://scenes/game_over.tscn"

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() - 1 )

func game_over(end_wisdom, age):
	call_deferred("_deferred_game_over", end_wisdom, age)

func transition(scene):
	call_deferred("_deferred_transition", scene)

func _deferred_transition(scene):
	
	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	
	# Load new scene
	var s = ResourceLoader.load(scene)
	
	# Instance the new scene
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )

func _deferred_game_over(wisdom, age):
	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	var s = ResourceLoader.load(GAME_OVER_SCENE)
	# Instance the new scene
	current_scene = s.instance()
	current_scene.wisdom = wisdom
	current_scene.age = age
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )