extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Sea = preload("res://sea.tscn")

var chunks = []

var currentChunkX = 0
var currentChunkY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-1,2): # -1, 0, 1
		for y in range (-1, 2):
			var sea = Sea.instance()
			add_child(sea)
			sea.set_position(Vector2(x * 500, y * 400))
			chunks.append(sea)
			sea.chunkX = x
			sea.chunkY = y

func shouldBeLoaded(var sea)->bool:
	var x = sea.chunkX
	var y = sea.chunkY
	return (x == currentChunkX || x+1 == currentChunkX || x-1 == currentChunkX) \
	&& (y == currentChunkY || y+1 == currentChunkY || y-1 == currentChunkY)

func ensureVisible(var x, var y):
	
	var sea
	
	for chunk in chunks:
		if chunk.chunkX == x && chunk.chunkY == y:
			sea = chunk
			break
	
	if not sea:
		sea = Sea.instance()
		add_child(sea)
		sea.set_position(Vector2(x * 500, y * 400))
		chunks.append(sea)
		sea.chunkX = x
		sea.chunkY = y
	
	sea.set_process(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_node("raft").get_global_position()
	var newChunkX = int(floor(pos.x / 500))
	var newChunkY = int(floor(pos.y / 400))
	
	if (currentChunkX != newChunkX || currentChunkY != newChunkY):
		currentChunkX = newChunkX
		currentChunkY = newChunkY
		
		for chunk in chunks:
			if not shouldBeLoaded(chunk):
				chunk.set_process(false)
		
		ensureVisible(currentChunkX-1, currentChunkY+1)
		ensureVisible(currentChunkX-1, currentChunkY)
		ensureVisible(currentChunkX-1, currentChunkY-1)
		
		ensureVisible(currentChunkX, currentChunkY+1)
		ensureVisible(currentChunkX, currentChunkY)
		ensureVisible(currentChunkX, currentChunkY-1)
		
		ensureVisible(currentChunkX+1, currentChunkY+1)
		ensureVisible(currentChunkX+1, currentChunkY)
		ensureVisible(currentChunkX+1, currentChunkY-1)

