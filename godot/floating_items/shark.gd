extends "res://floating_items/floating_item.gd"

var sprites = [
	preload("res://images/shark.png"),
	preload("res://images/octopus.png")
]

func _ready():
	randomize()
	get_node("sprite").texture = sprites[randi()%len(sprites)]