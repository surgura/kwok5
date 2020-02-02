extends "res://floating_items/floating_item.gd"

export(int) var tier = 0
var max_tier : int = 3
var min_offset : float = 0.0
var max_offset : float = -320.0
var min_rotation : float = -PI / 4.0
var max_rotation : float = 0.0

func get_target_rotation() -> float:
	var fraction = (float(tier) / float(max_tier))
	return (1 - fraction) * min_rotation + fraction * max_rotation

func get_target_offset() -> float:
	var fraction = (float(tier) / float(max_tier))
	return (1 - fraction) * min_offset + fraction * max_offset

func _process(_delta):
	var sprite = get_node("sprite")
	sprite.offset.y = (63.0 * sprite.offset.y + get_target_offset()) / 64.0
	sprite.rotation = (63.0 * sprite.rotation + get_target_rotation()) / 64.0

func repair():
	self.tier += 1
