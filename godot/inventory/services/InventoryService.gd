extends Node2D

var ExampleItemScene = preload("res://inventory/scenes/ExampleItemScene.tscn")


var items = Array() 

# Called when the node enters the scene tree for the first time.
func _ready():	
	addItem("ExampleItem")
	addItem("ExampleItem")
	addItem("ExampleItem")
	removeItem("ExampleItem", 3)
	#addItem("ITEMNAMESTUFF2")
	#print(findItem("dgsg"))
	#print(findItem("exampleitem"))
	#print(removeItem("ExampleItem"))
	#print("--")
	outputInventoryToConsole()

func addItem(itemName):
	var itemInstance = null
	match itemName:
		"ExampleItem":
			customAddItem(ExampleItemScene.instance())
		_:
			print("Item (" + itemName + ") not found")
	return itemInstance

func customAddItem(itemInstance):
	var existingItem = findItem(itemInstance.Name)
	if (existingItem == null):
		items.push_front(itemInstance)
		self.add_child(itemInstance)
	else:
		existingItem.Quantity += itemInstance.Quantity
		#existingItem.UpdateGraphics()

func findItem(itemName):
	for i in range(0, items.size()):
		if (items[i].Name == itemName):
			return items[i]
	return null

func removeItem(itemName, quantity):
	var itemInstance = findItem(itemName)
	if (itemInstance == null):
		return false
	else:
		if (quantity > itemInstance.Quantity):
			return false
		else:
			itemInstance.Quantity -= quantity
			if (itemInstance.Quantity == 0):
				items.erase(itemInstance)
				itemInstance.queue_free()
				print("removed " + itemInstance.Name)
			else:
				print("removed " + str(itemInstance.Quantity) + itemInstance.Name)
			return true

func getTotalWeight():
	var totalWeight = 0
	for i in range(0, items.size()):
		totalWeight += items[i].weight
	return totalWeight

func outputInventoryToConsole():
	for i in range(0, items.size()):
		print(str(i) + " " + items[i].Name + "(" + str(items[i].Quantity)+ ")")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
