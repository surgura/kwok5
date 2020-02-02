extends "res://floating_items/floating_item.gd"

func on_hit_raft() -> void:
	get_node("../../gui/textbox").show_stuff("Hoi", preload("res://images/character01.png"))