extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	get_node("world").hide()
	#get_node("MainMenu").show()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_MainMenu_start_game():
	print("start the game!")
	get_node("gui/MainMenu").hide()
	get_node("world").show()
	get_tree().paused = false
	pass # Replace with function body.
