extends Node2D

export(float) var waveHeight = 0

export(int) var worldIndexX
export(int) var worldIndexY
export(float) var worldPosX
export(float) var worldPosY

var random = RandomNumberGenerator.new()


func updateSprite():
	var sprite = get_node("AnimatedSprite")
	var maxIndex = sprite.frames.get_frame_count("default")
	var randomSeed = worldIndexX % 300 + ((79 + worldIndexY) % 311) * 300
	random.set_seed(randomSeed)
	var spriteIndex = random.randi_range(0, maxIndex)
	var spriteFlipped = bool(random.randi_range(0, 1))
	if (sprite.frame != spriteIndex):
		sprite.frame = spriteIndex
	if (sprite.flip_h != spriteFlipped):
		sprite.flip_h = spriteFlipped


