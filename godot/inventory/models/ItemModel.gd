extends Sprite

class_name ItemModel

var item_name: String
var durability_current: float
var durability_per_item: float
var weight: int
var quantity: int

var is_destructible: bool
var priority: int

# Decreases durability
# Returns excessive damage
func take_damage(damage: float) -> int:
	var new_durability = durability_current - damage
	set_durability(new_durability)
	if (self.durability_current <= 0): #rounds floating numbers
		quantity = 0
		durability_current = 0
		return -new_durability #returns excesive damage 
	return 0

# Updates quantity
func update_quantity():
	quantity = ceil(durability_current / durability_per_item)

# Sets durability
func set_durability(new_value: float) -> bool:
	if (is_destructible):
		durability_current = new_value
		update_quantity() #just update quantity if durability is set for now, put this in business logic later?
		return true
	else:
		return false

func init(item_name: String, durability: float, weight: int, is_destructible: bool, quantity: int, priority: int):
	self.item_name = item_name
	self.durability_current = durability
	self.durability_per_item = durability
	self.weight = weight
	self.is_destructible = is_destructible
	
	self.quantity = quantity 
	self.priority = priority
	print(name, durability_current, weight, is_destructible, quantity, priority)
	
func _ready():
	pass 

func _process(delta):
	pass
