extends Node2D

class_name item

export(String) var item_name: String
var durability_current: float
export(float) var durability_maximum: float
export(int) var weight: int

export(bool) var is_destructible: bool
export(int) var priority: int

const ICON_SIZE: int = 48

# Decreases durability
# Returns excessive damage
func take_damage(damage: float) -> int:
	var new_durability = durability_current - damage
	set_durability(new_durability)
	if (self.durability_current <= 0): #rounds floating numbers
		durability_current = 0
		return -new_durability #returns excesive damage 
	return 0

# Sets durability
func set_durability(new_value: float) -> bool:
	if (is_destructible):
		durability_current = new_value
		return true
	else:
		return false

func _ready():
	self.durability_current = self.durability_maximum
	var image = get_node("image")
	var texsize = image.texture.get_size()
	var scale: float = ICON_SIZE / max(texsize.x, texsize.y)
	image.set_scale(Vector2(scale, scale))
	
	var bg = get_node("background")
	texsize = bg.texture.get_size()
	scale = ICON_SIZE / max(texsize.x, texsize.y)
	bg.set_scale(Vector2(scale, scale))

func _process(delta):
	pass
