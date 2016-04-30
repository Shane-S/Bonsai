
extends Node2D

# by 200 seconds, we'll have reached the minimum time between weather events
const END_TIME = 200.0 

const END_INTERVAL = {"high" : 1.5, "low" : 0.75}
const START_INTERVAL = {"high" : 10.0, "low" : 8.5}

func _ready():
	get_node("light_timer").set_wait_time(START_INTERVAL.high)
	pass


func _on_light_timer_timeout():
	var secs = clamp(OS.get_ticks_msec() / 1000.0, 0, END_TIME)
	var interp = secs / END_TIME
	var high = END_INTERVAL.high + ((START_INTERVAL.high - END_INTERVAL.high) * interp)
	var low = END_INTERVAL.low + ((START_INTERVAL.low - END_INTERVAL.low) * interp)
	var interval = {"high" : high, "low" : low}
	var new_wait_time = rand_range(interval.low, interval.high)
	
	get_node("light_timer").set_wait_time(new_wait_time)
	
	pass # replace with function body
