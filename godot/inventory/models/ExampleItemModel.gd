extends ItemModel


func _init():
	.init("ExampleItem", 10, 10, true, 1, 1)

func _ready():
	pass

func _draw():
	var sprite = get_node("Sprite");
	sprite.region_rect.size.y = 32
	pass
