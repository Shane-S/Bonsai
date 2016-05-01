
extends Node2D

const TEXTURES = {
	"green": ["res://assets/textures/green_leaves_1.png", "res://assets/textures/green_leaves_2.png"],
	"red": ["res://assets/textures/red_leaves_1.png", "res://assets/textures/red_leaves_2.png"],
	"blue": ["res://assets/textures/blue_leaves_1.png", "res://assets/textures/blue_leaves_2.png"],
	"pink": ["res://assets/textures/pink_leaves_1.png", "res://assets/textures/pink_leaves_2.png"],
}

export(Vector2) var ellipse_dims
export(int) var num_sprites

func _ready():
	randomize()
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func initialize(color):
	var textures = []
	for tex_path in TEXTURES[color]:
		textures.append(load(tex_path))
	for i in range(num_sprites):
		var tex_idx = randi() % textures.size()
		var sprite = Sprite.new()
		sprite.set_texture(textures[tex_idx])
		sprite.translate(random_point_in_ellipse())
		add_child(sprite)

func random_point_in_ellipse():
	var theta = randf() * 2 * PI
	var r = randf()
	var x = sqrt(r) * cos(theta)
	var y = sqrt(r) * sin(theta)
	return Vector2(x * ellipse_dims.x / 2, y * ellipse_dims.y / 2)