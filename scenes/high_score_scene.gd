
extends Panel

const MAIN_MENU_SCENE = "res://scenes/main_menu.tscn"

onready var ages = get_node("HBoxContainer/AgeList")
onready var wisdoms = get_node("HBoxContainer/WisdomList")
export(Font) var font = null

func _ready():
	get_node("Done").connect("pressed", self, "_on_done")
	
	var age_scores = get_node("/root/global").load_age_scores()
	var wisdom_scores = get_node("/root/global").load_wisdom_scores()
	age_scores.sort_custom(self, "compare_age")
	wisdom_scores.sort_custom(self, "compare_wisdom")
	var i = 0
	for score in age_scores:
		if i >= 15:
			break
		show_age(score["name"] + ": " + str(int(score["age"])))
		i = i + 1
	i = 0
	for score in wisdom_scores:
		if i >= 15:
			break
		show_wisdom(score["name"] + ": " + str(int(score["wisdom"])))
		i = i + 1

func compare_age(a1, a2):
	return a1["age"] > a2["age"]

func compare_wisdom(w1, w2):
	return w1["wisdom"] > w2["wisdom"]

func show_age(label_text):
	var l = Label.new()
	l.set_text(label_text)
	l.add_font_override("font",font)
	l.set_align(HALIGN_CENTER)
	ages.add_child(l)
	
func show_wisdom(label_text):
	var l = Label.new()
	l.set_text(label_text)
	l.add_font_override("font",font)
	l.set_align(HALIGN_CENTER)
	wisdoms.add_child(l)
	
func _on_done():
	get_node("/root/global").transition(MAIN_MENU_SCENE)