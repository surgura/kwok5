extends Sprite

export(int) var size: int = 100

func set_tex(tex: Texture):
	texture = tex
	var scale = size / max(texture.get_size().x, texture.get_size().y)
	set_scale(Vector2(scale, scale))