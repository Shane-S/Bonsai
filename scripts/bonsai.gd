
extends Node2D

# default wisdom zones for light and moisture
const DEFAULT_MOISTURE_ZONE = {"low_ok" : 10.0, "low_good" : 16, "high_good" : 24, "high_ok" : 30.0}
const DEFAULT_LIGHT_ZONE = {"low_ok" : 10.0, "low_good" : 17.5, "high_good" : 22.5, "high_ok" : 30.0}
const AGE_RATE = 10.0
const DRY_RATE = 1.0
const WISDOM_RATE = 30.0
const HEALTH_LOSS_RATE = 200.0
const START_HEALTH = 1000.0

const HEALTH_STATE = {GOOD = 0, LOW_OK = 1, LOW_BAD = 2, HIGH_OK = 3, HIGH_BAD = 4}

var moisture = 20.0
var light = 20.0

var moisture_state = HEALTH_STATE.GOOD
var light_state = HEALTH_STATE.GOOD

var quotes = [
"OMG such wise",
"Stumps are dead trees",
"Eat yo wheaties",
"Paper beats rock",
"Those who try really hard usually get good sometimes",
"Don't cheat on your math tests etc.",
"*Tree noises*"]

var wisdom = 0.0
var quotes_gotten = 0
var age = 0.0
var health = START_HEALTH

# The zones in which the tree will gain wisdom and not age
var moisture_zone
var light_zone

onready var shade = get_node("shade")
onready var watering_can = get_node("watering_can")
onready var lightbulb = get_node("light")
onready var weather = get_node("../Weather")

const TREES = ["res://scenes/tree1.tscn", "res://scenes/tree2.tscn", "res://scenes/tree3.tscn"]
var tree = null

func _ready():
	watering_can.connect("watering_can_clicked", self, "_on_watering_can_pressed")
	
	moisture_zone = DEFAULT_MOISTURE_ZONE
	light_zone = DEFAULT_LIGHT_ZONE
	
	randomize()
	
	var tree_scene = load(TREES[randi() % TREES.size()])
	tree = tree_scene.instance()
	moisture_zone["low_ok"] += tree.moisture_zone_adjust
	moisture_zone["low_good"] += tree.moisture_zone_adjust
	moisture_zone["high_ok"] += tree.moisture_zone_adjust
	moisture_zone["high_good"] += tree.moisture_zone_adjust
	
	light_zone["low_ok"] += tree.light_zone_adjust
	light_zone["low_good"] += tree.light_zone_adjust
	light_zone["high_ok"] += tree.light_zone_adjust
	light_zone["high_good"] += tree.light_zone_adjust
	
	add_child(tree)
	set_process(true)

func _process(delta):
	age += delta * AGE_RATE
	moisture -= delta * current_dry_rate()
	light += delta * current_light_rate()
	if(health <= 0):
		get_node("/root/global").game_over(wisdom, age)
	
	var all_good = true
	if(is_light_good()):
		if(light_state != HEALTH_STATE.GOOD):
			tree.make_leaves_healthy()
		light_state = HEALTH_STATE.GOOD
	else:
		handle_light(delta)
		all_good = false
	
	if(is_moisture_good()):
		if(moisture_state != HEALTH_STATE.GOOD):
			set_pot_texture(load("assets/textures/pot_normal.png"))
		moisture_state = HEALTH_STATE.GOOD
	else:
		handle_moisture(delta)
		all_good = false
		
	if(all_good):
		wisdom += delta * WISDOM_RATE
	
	if(wisdom >= 400 and quotes_gotten == 0):
		get_node("Quote").set_text(quotes[0])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 1
	
	if(wisdom >= 800 and quotes_gotten == 1):
		get_node("Quote").set_text(quotes[1])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 2
	
	if(wisdom >= 1200 and quotes_gotten == 2):
		get_node("Quote").set_text(quotes[2])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 3
	
	if(wisdom >= 1600 and quotes_gotten == 3):
		get_node("Quote").set_text(quotes[3])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 4
	
	if(wisdom >= 2000 and quotes_gotten == 4):
		get_node("Quote").set_text(quotes[4])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 5
	
	if(wisdom >= 2400 and quotes_gotten == 5):
		get_node("Quote").set_text(quotes[5])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 6
	
	if(wisdom >= 2800 and quotes_gotten == 6):
		get_node("Quote").set_text(quotes[6])
		get_node("Quote/AnimationPlayer").play("Quote")
		quotes_gotten = 7

func set_pot_texture(texture):
	tree.get_node("pot").set_texture(texture)
	
func current_light_rate():
	return weather.current_light_rate() + shade.current_light_mod() + lightbulb.current_light_mod()

func current_dry_rate():
	return weather.current_dry_rate()
	
func handle_moisture(delta):
	if(moisture < moisture_zone.low_good):
		if(moisture < moisture_zone.low_ok):
			moisture_state = HEALTH_STATE.LOW_BAD
			health -= HEALTH_LOSS_RATE * delta
			set_pot_texture(load("assets/textures/pot_dry.png"))
		else:
			moisture_state = HEALTH_STATE.LOW_OK
			set_pot_texture(load("assets/textures/pot_dry_ok.png"))
	elif(moisture > moisture_zone.high_good):
		if(moisture > moisture_zone.high_ok):
			moisture_state = HEALTH_STATE.HIGH_BAD
			health -= HEALTH_LOSS_RATE * delta
			set_pot_texture(load("assets/textures/pot_moist.png"))
		else:
			moisture_state = HEALTH_STATE.HIGH_OK
			set_pot_texture(load("assets/textures/pot_moist_ok.png"))

func handle_light(delta):
	if(light < light_zone.low_good):
		if(light < light_zone.low_ok):
			tree.make_leaves_icy()
			light_state = HEALTH_STATE.LOW_BAD
			health -= HEALTH_LOSS_RATE * delta
		else:
			tree.make_some_leaves_icy()
			light_state = HEALTH_STATE.LOW_OK
	elif(light > light_zone.high_good):
		if(light > light_zone.high_ok):
			tree.make_leaves_brown()
			light_state = HEALTH_STATE.HIGH_BAD
			health -= HEALTH_LOSS_RATE * delta
		else:
			tree.make_some_leaves_brown()
			light_state = HEALTH_STATE.HIGH_OK

func is_light_good():
	return (light >= light_zone.low_good and light <= light_zone.high_good)

func is_moisture_good():
	return (moisture >= moisture_zone.low_good and moisture <= moisture_zone.high_good)

func _on_watering_can_pressed():
	moisture += watering_can.water_amount

