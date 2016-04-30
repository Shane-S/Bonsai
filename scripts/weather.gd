
extends Node2D

signal weather_changed

var all_weathers = []
var cur_weather = null

func _ready():
	#get the default weather
	cur_weather = get_node("Sun")
	#construct the weathers list
	all_weathers.append(cur_weather)
	all_weathers.append(get_node("Rain"))
	all_weathers.append(get_node("Drought"))
	all_weathers.append(get_node("Winter"))
	update_visibilities()

func update_visibilities():
	for weather in all_weathers:
		if cur_weather == weather:
			weather.show()
		else:
			weather.hide()

func _on_Timer_timeout():
	#select a random next weather
	var idx = randi() % all_weathers.size()
	cur_weather = all_weathers[idx]
	update_visibilities()
	print("emitting signal weather changed")
	emit_signal("weather_changed")
