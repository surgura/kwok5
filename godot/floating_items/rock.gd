extends "res://floating_items/floating_item.gd"

var sprites = [
	preload("res://images/rock01.png"),
	preload("res://images/rock02.png")
]

func _ready():
	randomize()
	get_node("sprite").texture = sprites[randi()%len(sprites)]