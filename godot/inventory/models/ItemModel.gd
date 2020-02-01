extends Node2D

class_name ItemModel

var Name: String
var DurabilityCurrent: int
var DurabilityMaximum: int
var Weight: int
var Quantity: int

var IsDestructible: bool

func setDurability(newDurabilityValue):
	if (IsDestructible):
		DurabilityCurrent = clamp(newDurabilityValue, 0, DurabilityMaximum)
		return true
	else:
		return false

func init(name: String, durability: int, weight: int, isDestructible: bool, quantity: int):
	Name = name
	DurabilityCurrent = durability
	DurabilityMaximum = durability
	Weight = weight
	IsDestructible = isDestructible
	Quantity = quantity 
	print(Name, DurabilityCurrent, DurabilityMaximum, Weight, IsDestructible, Quantity)
	

func _ready():
	pass 

func _process(delta):
	pass
