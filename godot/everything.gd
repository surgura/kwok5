extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#timeout is what says in docs, in signals
#self is who respond to the callback
#_on_timer_timeout is the callback, can have any name
 #to process
var introTimer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	introTimer = Timer.new()
	introTimer.set_wait_time(5)
	introTimer.connect("timeout", self, "_on_timer_timeout") 
	add_child(introTimer)
	get_node("world").hide()
	get_tree().paused = true
	#get_node("MainMenu").show()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MainMenu_start_game():
	introTimer.start()
	get_node("gui/mainMenu").hide()
	get_node("gui/intro").frame = 68
	get_node("gui/intro").playing = true
	pass # Replace with function body.

func _on_timer_timeout():
	introTimer.stop()
	get_node("world").show()
	get_tree().paused = false
	get_node("gui/intro").hide()
	print("starting game")
