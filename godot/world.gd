extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Sea = preload("res://sea.tscn")

var chunks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-1,2): # -1, 0, 1
		for y in range (-1, 2):
			var sea = Sea.instance()
			add_child(sea)
			sea.set_position(Vector2(x * 500, y * 400))
			chunks.append(sea)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_node("raft").get_global_position()
	var chunkX = int(floor(pos.x / 500))
	var chunkY = int(floor(pos.y / 400))
	print (chunkX, " ", chunkY)
	pass
