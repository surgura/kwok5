extends Control

signal on_close
export(NodePath) var world: NodePath

func show_stuff(text: String, tex: Texture):
	get_node("text").text = text
	get_node("sprite").set_tex(tex)
	visible = true
	get_node(world).get_tree().paused = true
	
func hide():
	visible = false
	
func _process(_delta):
	if Input.is_action_just_pressed("test"):
		print("close")
		hide()
		get_node(world).get_tree().paused = false
		emit_signal("on_close")