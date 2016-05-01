
extends Node

const GAME_OVER_SCENE = "res://scenes/game_over.tscn"
const WISDOM_SCORES_FILE = "user://wisdomscores.json"
const AGE_SCORES_FILE = "user://agescores.json"
const NUM_HISCORES = 15
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() - 1 )

func game_over(end_wisdom, age):
	var age_scores = load_age_scores()
	var wisdom_scores = load_wisdom_scores()
	var is_age_hiscore = age_scores.size() < NUM_HISCORES
	var is_wisdom_hiscore = wisdom_scores.size() < NUM_HISCORES
	for score in age_scores:
		if age > score["age"]:
			is_age_hiscore = true
			break
	for score in wisdom_scores:
		if end_wisdom > score["wisdom"]:
			is_wisdom_hiscore = true
			break
	call_deferred("_deferred_game_over", end_wisdom, age, is_wisdom_hiscore, is_age_hiscore)

func transition(scene):
	call_deferred("_deferred_transition", scene)


func load_age_scores():
	return load_high_scores(AGE_SCORES_FILE)
	
func load_wisdom_scores():
	return load_high_scores(WISDOM_SCORES_FILE)

func load_high_scores(filename):
	var file = File.new()
	if !file.file_exists(filename):
		return []
	file.open(filename, File.READ)
	var high_scores = []
	while !file.eof_reached():
		var current_line = {}
		var line = file.get_line()
		if !line.empty():
			current_line.parse_json(line)
			high_scores.append(Dictionary(current_line))
	file.close()
	return high_scores

func save_age_score(name, age):
	var old_high_scores = load_age_scores()
	old_high_scores.append({
		"name": name,
		"age": age
	})
	save_age_scores(old_high_scores)

func save_wisdom_score(name, wisdom):
	var old_high_scores = load_wisdom_scores()
	old_high_scores.append({
		"name": name,
		"wisdom": wisdom
	})
	save_wisdom_scores(old_high_scores)

func save_age_scores(high_scores):
	var file = File.new()
	file.open(AGE_SCORES_FILE, File.WRITE)
	for entry in high_scores:
		file.store_line(entry.to_json())
	file.close()
	
func save_wisdom_scores(high_scores):
	var file = File.new()
	file.open(WISDOM_SCORES_FILE, File.WRITE)
	for entry in high_scores:
		file.store_line(entry.to_json())
	file.close()

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

func _deferred_game_over(wisdom, age, is_wisdom_hiscore, is_age_hiscore):
	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	var s = ResourceLoader.load(GAME_OVER_SCENE)
	# Instance the new scene
	current_scene = s.instance()
	current_scene.wisdom = wisdom
	current_scene.age = age
	current_scene.is_wisdom_hiscore = is_wisdom_hiscore
	current_scene.is_age_hiscore = is_age_hiscore
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )