extends Control

export(NodePath) var player
export(NodePath) var ship





# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (ship && player):
		
		var shipPos = get_node(ship).get_global_position()
		var playerPos = get_node(player).get_global_position()
		var diff = playerPos - shipPos
		get_node("needle").set_rotation(diff.angle() - 0.5 * PI)
	
