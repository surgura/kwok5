extends Sprite

class_name ItemModel

var item_name: String
var durability_current: float
var durability_per_item: float
var weight: int

var is_destructible: bool
var priority: int

const ICON_SIZE: int = 64

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

func init(item_name: String, durability: float, weight: int, is_destructible: bool, priority: int):
	self.item_name = item_name
	self.durability_current = durability
	self.durability_per_item = durability
	self.weight = weight
	self.is_destructible = is_destructible
	
	self.priority = priority
	print(name, durability_current, weight, is_destructible, priority)

func _ready():
	var texsize = texture.get_size()
	var scale: float = ICON_SIZE / max(texsize.x, texsize.y)
	set_scale(Vector2(scale, scale))

func _process(delta):
	pass
