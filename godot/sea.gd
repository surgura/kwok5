extends Node2D

export(float) var weather = 1

var Wave = preload("res://wave.tscn")

const numColumns = 5
const numRows = 10

const waveDistanceX = 110
const waveDistanceY = 40

const waveAmplitude = 20

var noiseScaleX = 1
var noiseScaleY = 1
var noiseScaleZ = 2

var time = 0.0
var noise = OpenSimplexNoise.new()
var waves = []

var random = RandomNumberGenerator.new()

func _ready():
	
	noise.seed = 0
	noise.octaves = 3
	noise.period = 10.0
	noise.persistence = 0.4
	
	for x in range(numColumns):
		waves.append([])
		waves[x] = []
		for y in range(numRows):
			waves[x].append(Wave.instance())
			self.add_child(waves[x][y])
			
			var pos = Vector2(x * waveDistanceX, y * waveDistanceY)
			if y % 2 == 0:
				pos.x += 0.5 * waveDistanceX
			
			waves[x][y].basePosition = pos
			
			waves[x][y].setup(random)
	
	#for x in range(numColumns):
#		for y in range(numRows):


func _process(delta):
	time += delta
	
	for x in range(numColumns):
		for y in range(numRows):
			
			waves[x][y].set_transform(Transform2D(0, waves[x][y].basePosition))
			var globalPos = waves[x][y].get_global_position()
			
			waves[x][y].waveHeight = (weather * waveAmplitude) * \
				noise.get_noise_3d(noiseScaleX * globalPos.x, \
								   noiseScaleY * globalPos.y, \
								   noiseScaleZ * time);
								
								
	for y in range(numRows):
		for x in range(numColumns):
			
			var curr = waves[x][y].basePosition
			curr.y += waves[x][y].waveHeight
			var prev
			var next
			
			if x == 0:
				prev = curr - Vector2(waveDistanceX, 0)
			else:
				prev = waves[x-1][y].basePosition
				prev.y += waves[x-1][y].waveHeight
			
			if x == numColumns - 1:
				next = curr + Vector2(waveDistanceX, 0)
			else:
				next = waves[x+1][y].basePosition
				next.y += waves[x+1][y].waveHeight
			
			# now we have the point to the left, to the right and this
			
			var angle = 2 * ((next - curr).angle() + (curr - prev).angle())
			
			var rowDisplacementX = 100 * noise.get_noise_2d(y * 100, time * noiseScaleZ / 2)
			
			var finalPos = waves[x][y].basePosition
			finalPos.y += waves[x][y].waveHeight
			finalPos.x += rowDisplacementX;
			
			waves[x][y].set_transform(Transform2D(angle, finalPos))
			
		










