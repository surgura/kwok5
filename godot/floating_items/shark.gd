extends "res://floating_items/floating_item.gd"

func _init().(false, true, false):
	pass

func get_damage(ship_weight, ship_velocity : Vector2, inventory_items : Array) -> float:
	return 6.0 #TODO: Less damage when having shark repellant.
