extends "res://floating_items/floating_item.gd"

func on_hit_raft() -> void:
	var textbox = get_tree().get_root().find_node("textbox", true, false)
	textbox.show_stuff("This is pineapple yo", get_node("sprite").texture)
	if destroy_trigger == Trigger.IMPACT or (destroy_trigger == Trigger.CATCH and is_being_reeled):
		self.queue_free()
