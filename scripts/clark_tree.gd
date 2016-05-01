
extends Sprite

const COLOURS = ["green", "red", "blue", "pink"]
const CLUMPS = 4
var moisture_zone_adjust = 0
var light_zone_adjust = 0

func _ready():
	for i in range(CLUMPS):
		var colour = randi() % 4
		get_node("LeafClump" + str(i+1)).initialize(COLOURS[colour])
	
		# change the moisture and light values according to the colours
		if(colour == 0):
			moisture_zone_adjust += 1.2
		elif(colour == 1):
			moisture_zone_adjust -= 1.2
		elif(colour == 2):
			light_zone_adjust += 1.2
		else:
			light_zone_adjust -= 1.2

