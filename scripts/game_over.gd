
extends Node2D

const HIGH_SCORE_SCENE = "res://scenes/high_score_scene.tscn"

var wisdom = 0
var age = 0
var is_wisdom_hiscore = false
var is_age_hiscore = false
var initials = ""

onready var wisdom_label = get_node("WisdomLabel")
onready var age_label = get_node("AgeLabel")

func _ready():
	get_node("enter_hiscore").connect("ok_pressed", self, "_on_enter_hiscore_ok_pressed")
	get_node("continue").connect("pressed", self, "_on_continue_pressed")
	if is_wisdom_hiscore or is_age_hiscore:
		get_node("enter_hiscore").show()
	wisdom_label.set_text("Your Wisdom: " + str(int(wisdom)))
	age_label.set_text("Your Age: " + str(int(age)) + " Years")
	


func _on_enter_hiscore_ok_pressed():
	initials = get_node("enter_hiscore").initials
	if is_wisdom_hiscore:
		get_node("/root/global").save_wisdom_score(initials, wisdom)
	if is_age_hiscore:
		get_node("/root/global").save_age_score(initials, age)
	get_node("enter_hiscore").hide()

func _on_continue_pressed():
	get_node("/root/global").transition(HIGH_SCORE_SCENE)