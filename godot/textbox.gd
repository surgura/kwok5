extends Control

func show_stuff(text: String, tex: Texture):
	get_node("text").text = text
	get_node("sprite").set_tex(tex)
	visible = true
	
func hide():
	visible = false