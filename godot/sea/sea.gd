extends Node2D

const Wave = preload("wave.tscn")
var wave_margin: Vector2 = Vector2(100, 100)
var wave_extra: int = 3
var time = 0

func _process(_delta):
	var grid_x: int = int(get_viewport().size.x / wave_margin.x)+wave_extra*2
	var grid_y: int = int(get_viewport().size.y / wave_margin.y)+wave_extra*2
	
	resize_waves_pool(grid_x, grid_y)
	
	time += _delta * 100
	var offset_x = int(time)
	var offset_y = int(time)
	
	for y in range(grid_y):
		for x in range(grid_x):
			var wave = get_children()[y * grid_x + x]
			var pos_x = (x-wave_extra) * wave_margin.x
			var pos_y = (y-wave_extra) * wave_margin.y
			var real_x = offset_x + pos_x
			var real_y = offset_y + pos_y
			wave.position.x = pos_x + offset_x % int(wave_margin.x)
			wave.position.y = pos_y + offset_y % int(wave_margin.y)
	
func resize_waves_pool(width_x: int, width_y: int) -> void:
	var wave_count: int = width_x * width_y
	var diff: int = wave_count - len(get_children())
	if diff > 0:
		for _i in range(diff):
			add_child(Wave.instance())
	elif diff < 0:
		for _i in range(-diff):
			var child = get_children()[0]
			remove_child(child)
			child.queue_free()
