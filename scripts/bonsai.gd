
extends Node2D

# default wisdom zones for light and moisture
const DEFAULT_MOISTURE_ZONE = {"low" : 10.0, "high" : 30.0}
const DEFAULT_LIGHT_ZONE = {"low" : 10.0, "high" : 30.0}

var moisture = 0.0
var light = 0.0
var wisdom = 0.0
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
	var sprite_textures = []
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
		sprite_textures.push_back(load("assets//textures//branch" + str(i) + "_" + colours[colour] + ".png"))
	
	get_node("trunk/branch0").set_texture(sprite_textures[0])
	get_node("trunk/branch1").set_texture(sprite_textures[1])
	get_node("trunk/branch2").set_texture(sprite_textures[2])
	get_node("trunk/branch3").set_texture(sprite_textures[3])
	get_node("trunk/branch4").set_texture(sprite_textures[4])
	get_node("trunk/branch5").set_texture(sprite_textures[5])
	
	
	set_process(true)
	pass

func _process(delta):
	