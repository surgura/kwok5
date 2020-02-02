tool
extends Node2D

const wave: Texture = preload("res://images/wave1.png")

const width: int = 100

func _process(delta):
	update()

func _draw():
	for i in range(0, int(get_viewport().size.x / width) + 1):
		draw_texture(wave, Vector2(i*widt4h, 100) - wave.get_size() / 2.0)