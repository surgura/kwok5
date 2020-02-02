extends Control


signal start_game




func _on_button_pressed():
	print("emitting start game signal")
	emit_signal("start_game")


func _on_button_mouse_entered():
	get_node("playButton/TextureRect").visible = true


func _on_button_mouse_exited():
	get_node("playButton/TextureRect").visible = false


func _on_creditsButton_pressed():
	get_node("credits").visible = true
	print("Created by: ...")


func _on_creditsButton_mouse_entered():
	get_node("creditsButton/TextureRect").visible = true


func _on_creditsButton_mouse_exited():
	get_node("creditsButton/TextureRect").visible = false


func _on_Button_pressed():
	get_node("credits").visible = false
