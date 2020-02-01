extends Node2D

var ExampleItemScene = preload("res://inventory/scenes/ExampleItemScene.tscn")

var items = Array() 

# Called when the node enters the scene tree for the first time.
func _ready():	
	add_item("ExampleItem")
	add_item("ExampleItem")
	add_item("ExampleItem")
	take_damage(31)
	output()

# Reduces durability
func take_damage(damage: float):
	var head = items.front()
	if (head == null):
		return
		
	head.take_damage(damage)
	if (head.durability_current <= 0):
		remove_item(head.item_name, head.quantity)

# Adds item to inventory
func add_item(item_name: String) -> Object:
	var item_instance = null
	match item_name:
		"ExampleItem":
			_custom_add_item(ExampleItemScene.instance())
		_:
			print("Item (" + item_name + ") not found")
	return item_instance

# Finds item with given item_name
func find_item(item_name: String) -> Object:
	for i in range(0, items.size()):
		if (items[i].item_name == item_name):
			return items[i]
	return null

# Removes item with given item_name, quantity: number of items to remove
func remove_item(item_name: String, quantity: int) -> bool:
	var item_instance = find_item(item_name)
	if (item_instance == null):
		return false
	else:
		if (quantity > item_instance.quantity):
			return false
		else:
			item_instance.quantity -= quantity
			item_instance.durability_current -= (quantity * item_instance.durability_per_item)
			if (item_instance.quantity == 0):
				items.erase(item_instance)
				item_instance.queue_free()
				print("removed " + item_instance.item_name)
			else:
				print("removed " + str(item_instance.quantity) + item_instance.item_name)
			return true

# Helper function to add item instances to inventory
func _custom_add_item(item_instance: Object):
	var existingItem = find_item(item_instance.item_name)
	if (existingItem == null):
		items.push_front(item_instance)
		self.add_child(item_instance)
	else:
		existingItem.quantity += item_instance.quantity
		existingItem.durability_current += item_instance.durability_current
		#existingItem.UpdateGraphics()

# Gets total weight of items
func get_total_weight() -> int:
	var total_weight = 0
	for i in range(0, items.size()):
		total_weight += items[i].weight
	return total_weight

# Gets total durability of items
func get_total_turability() -> int:
	var total_durability = 0
	for i in range(0, items.size()):
		total_durability += items[i].current_durability
	return total_durability

# Debug stuff
func output():
	for i in range(0, items.size()):
		print(
		  "NAME:         " + items[i].item_name 
		+ "\nDURABILITY: " + str(items[i].durability_current)
		+ "\nQUANTITY:   " + str(items[i].quantity)
		)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass