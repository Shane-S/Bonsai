
extends Node2D

var wisdom = 0
var age = 0

onready var wisdom_label = get_node("WisdomLabel")
onready var age_label = get_node("AgeLabel")

func _ready():
	wisdom_label.set_text("Your Wisdom: " + str(int(wisdom)))
	age_label.set_text("Your Age: " + str(int(age)) + " Years")
