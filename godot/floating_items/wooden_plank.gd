extends "res://floating_items/floating_item.gd"

func can_pickup(inventory : Object) -> bool:
	return true

func get_item():
	return "wooden_plank"