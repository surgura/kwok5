extends Node2D

const Wave = preload("wave.tscn")
var wave_margin: Vector2 = Vector2(100, 100)

func _process(delta):
	resize_waves_pool()
	pass
	
func resize_waves_pool() -> void:
	var grid_x: int = int(get_viewport().size.x / wave_margin.x) + 1
	var grid_y: int = int(get_viewport().size.y / wave_margin.y) + 1
	var wave_count: int = grid_x * grid_y
	var diff: int = wave_count - len(get_children())
	if diff > 0:
		add_child(Wave.instance())
	elif diff < 0:
		for _i in range(0, -diff):
			var child = get_children()[0]
			remove_child(child)
			child.queue_free()