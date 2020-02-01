extends Node2D

export(Vector2) var playerPosition
export(float)   var weather = 1

var Wave = preload("res://wave.tscn")

const numColumns = 15
const numRows = 30

const waveDistanceX = 200
const waveDistanceY = 40

const waveAmplitude = 30

var noiseScaleX = 1
var noiseScaleY = 1
var noiseScaleZ = 2

var time = 0.0
var noise = OpenSimplexNoise.new()
var waves = []


func isEven(value:int):
	return value % 2 == 0



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
			waves[x][y].set_z_index(y)
			self.add_child(waves[x][y])



func _process(delta):
	time += delta

	var indexOffsetX = int(floor(playerPosition.x / waveDistanceX))
	var indexOffsetY = int(floor(playerPosition.y / waveDistanceY))
	
	for x in range(numColumns):
		for y in range(numRows):
			
			waves[x][y].worldIndexX = indexOffsetX + x
			waves[x][y].worldIndexY = indexOffsetY + y
			
			var worldX = (indexOffsetX + x) * waveDistanceX
			var worldY = (indexOffsetY + y) * waveDistanceY
			
			if isEven((indexOffsetY + y)):
				worldX += (0.5 * waveDistanceX)
				
			waves[x][y].worldPosX = worldX
			waves[x][y].worldPosY = worldY
			
			waves[x][y].waveHeight = (weather * waveAmplitude) * \
				noise.get_noise_3d(noiseScaleX * worldX, \
								   noiseScaleY * worldY, \
								   noiseScaleZ * time);
								
	for x in range(numColumns):
		for y in range(numRows):
			
			var curr = Vector2(waves[x][y].worldPosX, waves[x][y].worldPosY + waves[x][y].waveHeight)
			var prev
			var next
			
			if x == 0:
				prev = curr - Vector2(waveDistanceX, 0)
			else:
				prev = Vector2(waves[x-1][y].worldPosX, waves[x-1][y].worldPosY + waves[x-1][y].waveHeight)
			
			if x == numColumns - 1:
				next = curr + Vector2(waveDistanceX, 0)
			else:
				next = Vector2(waves[x+1][y].worldPosX, waves[x+1][y].worldPosY + waves[x+1][y].waveHeight)
			
			# now we have the point to the left, to the right and this
			
			var angle = 2 * ((next - curr).angle() + (curr - prev).angle())
			
			var screenPosX = waves[x][y].worldPosX - playerPosition.x
			var screenPosY = waves[x][y].worldPosY - playerPosition.y
			
			screenPosY += waves[x][y].waveHeight
			
			var pos = Vector2(screenPosX, screenPosY)
			
			waves[x][y].set_transform(Transform2D(angle, pos))
			waves[x][y].updateSprite()
		










