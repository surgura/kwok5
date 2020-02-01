extends Node2D

export(Vector2) var playerPosition
export(float) var waveHeight = 30

var Wave = preload("res://wave.tscn")

const numColumns = 7
const numRows = 5

const waveDistanceX = 120
const waveDistanceY = 70

var time = 0.0
var noise = OpenSimplexNoise.new()
var waves = []


func isEven(value:int):
	return value % 2 == 0


func _ready():
	
	noise.seed = randi()
	noise.octaves = 1
	noise.period = 10.0
	noise.persistence = 0.6
	
	for x in range(numColumns):
		waves.append([])
		waves[x] = []
		for y in range(numRows):
			waves[x].append(Wave.instance())
			waves[x][y].set_z_index(y)
			self.add_child(waves[x][y])


func _process(delta):
	time += delta
	
	playerPosition.x += 1
	playerPosition.y -= 1

	var indexOffsetX = int(floor(playerPosition.x / waveDistanceX))
	var indexOffsetY = int(floor(playerPosition.y / waveDistanceY))
	
	for x in range(numColumns):
		for y in range(numRows):
			
			var worldIndexX = indexOffsetX + x
			var worldIndexY = indexOffsetY + y
			
			var worldPosX = worldIndexX * waveDistanceX
			var worldPosY = worldIndexY * waveDistanceY
			
			if isEven(worldIndexY):
				worldPosX += (0.5 * waveDistanceX)
			
			var screenPosX = worldPosX - playerPosition.x
			var screenPosY = worldPosY - playerPosition.y
			
			var angle = 0.5 * noise.get_noise_3d(worldPosX, worldPosY, 6 * time);
			screenPosY += waveHeight * noise.get_noise_3d(worldPosX, worldPosY, 4 * time + 10000);
			
			var pos = Vector2(screenPosX, screenPosY)
			
			waves[x][y].set_transform(Transform2D(angle, pos))
			
	pass










