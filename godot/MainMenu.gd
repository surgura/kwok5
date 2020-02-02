extends Control


signal start_game




func _on_button_pressed():
	print("emitting start game signal")
	emit_signal("start_game")


func _on_button_mouse_entered():
	get_node("playButton/TextureRect").visible = true


func _on_button_mouse_exited():
	get_node("playButton/TextureRect").visible = false
