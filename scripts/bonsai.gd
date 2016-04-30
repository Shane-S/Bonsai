
extends Node2D

# default wisdom zones for light and moisture
const DEFAULT_MOISTURE_ZONE = {"low" : 10.0, "high" : 30.0}
const DEFAULT_LIGHT_ZONE = {"low" : 10.0, "high" : 30.0}
const AGE_RATE = 10.0

var moisture = 20.0
var light = 20.0
var wisdom = 0.0
var age = 0.0
var max_age = 1000.0 # algorithm for determining max age may change; currently, if the player gets a perfect run, their tree will be 1000

var branch_colours = []

# The zones in which the tree will gain wisdom and not age
var moisture_zone
var light_zone

func _ready():
	moisture_zone = DEFAULT_MOISTURE_ZONE
	light_zone = DEFAULT_LIGHT_ZONE
	
	randomize()
	
	# create the random branch colours
	# HACKS INBOUND
	var colours = ["green", "orange", "blue", "yellow"]
	for i in range(6):
		var rnd = randi()
		var colour = rnd % 4
		branch_colours.push_back(colours[colour])
	
		# change the moisture and light values according to the colours
		if(colour == 0):
			moisture_zone["low"] += 1.2
			moisture_zone["high"] += 1.2
		elif(colour == 1):
			moisture_zone["low"] -= 1.2
			moisture_zone["high"] -= 1.2
		elif(colour == 2):
			light_zone["low"] += 1.2
			light_zone["high"] += 1.2
		else:
			light_zone["low"] -= 1.2
			light_zone["high"] -= 1.2
	
		# assign the appropriate branch type based on the colour selection
		get_node("trunk/branch" + str(i)).set_texture(load("assets//textures//branch" + str(i) + "_" + colours[colour] + ".png"))
	
	set_process(true)
	pass

func _process(delta):
	age += delta * AGE_RATE
	if(age >= max_age):
		age = max_age
		# game over
		return
	
	# TODO: add absolute max and min, and stop game once one of these is hit
	if(moisture >= moisture_zone.low and moisture <= moisture_zone.high and
	   light >= light_zone.low and light <= light_zone.high):
		wisdom += 0.5
	else:
		if(moisture < moisture_zone.low):
			var diff = moisture_zone.low - moisture
			max_age -= diff
		elif(moisture > moisture_zone.high):
			var diff = moisture - moisture_zone.high
			max_age -= diff
		
		if(light < light_zone.low):
			var diff = light_zone.low - light
			max_age -= diff
		elif(light > light_zone.high):
			var diff = light - light_zone.high
			max_age -= diff
		
	