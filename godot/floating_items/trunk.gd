extends "res://floating_items/floating_item.gd"

var sprites = [
	preload("res://images/plank01.png"),
	preload("res://images/trunk01.png")
]

func _ready():
	print(randi()%2)
	get_node("sprite").texture = sprites[randi()%2]