extends Node2D

var items = Array()

const item_scene = preload("res://inventory/scenes/ItemScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	addItem("ITEMNAMESTUFF")
	addItem("ITEMNAMESTUFF2")
	print(findItem("ITEMNAMESTUFF"))
	print(findItem("ITEMNAMESTUFF2"))
	print(removeItem("ITEMNAMESTUFF2"))
	print("--")
	outputInventoryToConsole()

func addItem(itemName):
	var item_instance = item_scene.instance()
	item_instance.item_name = itemName
	get_node("../").add_child(item_instance)
	items.append(item_instance)
	print("added ", item_instance.weight)

func findItem(itemName):
	for i in range(0, items.size()):
		if (items[i].item_name == itemName):
			return items[i]
	return null

func removeItem(itemName):
	var item_instance = findItem(itemName)
	if (item_instance == null):
		return false
	else:
		items.erase(item_instance)
		print("removed ", item_instance)
		return true

func getTotalWeight():
	var totalWeight = 0
	for i in range(0, items.size()):
		totalWeight += items[i].weight
	return totalWeight

func outputInventoryToConsole():
	for i in range(0, items.size()):
		print(str(i) + " " + items[i].item_name)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
