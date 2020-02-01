extends Node2D

export(float) var waveHeight = 0
export(Vector2) var basePosition


func setup(var random:RandomNumberGenerator):
	var sprite = get_node("AnimatedSprite")
	var maxIndex = sprite.frames.get_frame_count("default")
	var spriteIndex = random.randi_range(0, maxIndex)
	var spriteFlipped = bool(random.randi_range(0, 1))
	sprite.frame = spriteIndex
	sprite.flip_h = spriteFlipped
	self.z_as_relative = false
	self.z_index = self.basePosition.y + self.global_position.y
