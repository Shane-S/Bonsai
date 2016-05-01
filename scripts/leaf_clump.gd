
extends Node2D

const TEXTURES = {
	"green": ["res://assets/textures/green_leaves_1.png", "res://assets/textures/green_leaves_2.png"],
	"red": ["res://assets/textures/red_leaves_1.png", "res://assets/textures/red_leaves_2.png"],
	"blue": ["res://assets/textures/blue_leaves_1.png", "res://assets/textures/blue_leaves_2.png"],
	"pink": ["res://assets/textures/pink_leaves_1.png", "res://assets/textures/pink_leaves_2.png"],
	"brown": ["res://assets/textures/brown_leaves_1.png", "res://assets/textures/brown_leaves_2.png"]
}

export(Vector2) var ellipse_dims = Vector2(50, 50)
export(int) var num_sprites = 10
export(float) var brown_prob = 0.5

var healthy_color = null
var healthy_textures = []
var brown_textures = []
var sprites = []

func _ready():
	for tex_path in TEXTURES["brown"]:
		brown_textures.append(load(tex_path))
	randomize()
	


func initialize(color):
	healthy_color = color
	for tex_path in TEXTURES[color]:
		healthy_textures.append(load(tex_path))
	for i in range(num_sprites):
		var tex_idx = randi() % healthy_textures.size()
		var sprite = Sprite.new()
		sprite.set_texture(healthy_textures[tex_idx])
		sprite.translate(random_point_in_ellipse())
		sprite.set_z(randi() % 3)
		add_child(sprite)
		sprites.append({
			"sprite": sprite, 
			"tex_idx": tex_idx
		})

func random_point_in_ellipse():
	var theta = randf() * 2 * PI
	var r = randf()
	var x = sqrt(r) * cos(theta)
	var y = sqrt(r) * sin(theta)
	return Vector2(x * ellipse_dims.x / 2, y * ellipse_dims.y / 2)
	
func restore():
	get_node("Icicles").hide()
	for sprite_obj in sprites:
		sprite_obj["sprite"].set_texture(healthy_textures[sprite_obj["tex_idx"]])

func make_icy():
	get_node("Icicles").show()

func make_brown():
	for sprite_obj in sprites:
		if randf() > brown_prob:
			sprite_obj["sprite"].set_texture(brown_textures[sprite_obj["tex_idx"]])