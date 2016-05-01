
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	pass

func _process(delta):
	var bonsai = get_parent().get_node("bansai")
	var percent = bonsai.health / bonsai.START_HEALTH
	var health_display = get_node("health")
	health_display.set_scale(Vector2(percent, 1))
	health_display.set_pos(Vector2((-health_display.get_texture().get_width() / 2) * (1 - percent), 0))