extends Node2D

var hook_scene = preload("res://hook.tscn")
var hook_instance = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("throw_hook"):
		if hook_instance == null:
			hook_instance = hook_scene.instance()
			hook_instance.raft_path = self.get_path()
			get_node("../").add_child(hook_instance)
