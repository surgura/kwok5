extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var World = preload("res://world.tscn")

var world = null

# Called when the node enters the scene tree for the first time.
func _ready():
	resetUniverse()
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		resetUniverse()


func resetUniverse():
	if (world):
		remove_child(world)
	world = World.instance()
	add_child(world)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
