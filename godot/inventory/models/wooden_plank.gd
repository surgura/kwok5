extends ItemModel

func _init():
	.init("wooden_plank", 10, 10, true, 1, 1)

func _draw():
	region_rect.size.y = 32
