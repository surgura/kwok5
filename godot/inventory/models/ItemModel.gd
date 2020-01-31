extends Node2D

var item_name = "itemname"
var current_durability = 10 #variable
var maximum_durability = 10 #const?

var isDestructible = true

var weight = 10 #const?

func set_durability(newDurabilityValue):
	if (isDestructible):
		current_durability = clamp(newDurabilityValue, 0, maximum_durability)
		return true
	else:
		return false


func _ready():
	pass 

func TakeDamage(amount):
	pass
