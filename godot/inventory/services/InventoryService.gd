extends Control

const ICON_SIZE: int = 48
const ITEMS_OFFSET: Vector2 = Vector2(16, 16)

var item_map = {
	"wooden_plank": preload("res://inventory/scenes/wooden_plank.tscn")
}

var items = Array() 
	
func _process(delta):
	var screen_size: Vector2 = get_viewport().size
	var bottom_offset: int = 0
	for i in range(len(items)-1, -1, -1):
		items[i].position.y = screen_size.y - ICON_SIZE/2 - int(ITEMS_OFFSET.y) - bottom_offset
		items[i].position.x = int(ITEMS_OFFSET.x) + ICON_SIZE/2
		bottom_offset += ICON_SIZE
		
		var dur_scale = items[i].durability_current / items[i].durability_maximum
		
		var image = items[i].get_node("image")
		image.region_enabled = true
		var base_size = ICON_SIZE / image.scale.x
		image.offset.y = base_size * (1-dur_scale)/2
		image.region_rect.position.y = base_size * (1-dur_scale)
		image.region_rect.size.x = base_size
		image.region_rect.size.y = base_size * dur_scale
		
		var background = items[i].get_node("background")
		background.region_enabled = true
		base_size = ICON_SIZE / background.scale.x
		background.offset.y = base_size * (1-dur_scale)/2
		background.region_rect.position.y = base_size * (1-dur_scale)
		background.region_rect.size.x = base_size
		background.region_rect.size.y = base_size * dur_scale

# Reduces durability
func take_damage(damage: float):
	var head = items.front()
	if (head == null):
		return
		
	head.take_damage(damage)
	if (head.durability_current <= 0):
		remove_item(head.item_name)

# Adds item to inventory
func add_item(item_name: String) -> Object:
	var item_instance = null
	if item_map.has(item_name):
		item_instance = _custom_add_item(item_map[item_name].instance())
		sort()
	else:
		print("Item (" + item_name + ") not found")
	return item_instance

# Finds item with given item_name
func find_item(item_name: String) -> Object:
	for i in range(0, items.size()):
		if (items[i].item_name == item_name):
			return items[i]
	return null

# Removes item with given item_name, quantity: number of items to remove
func remove_item(item_name: String) -> bool:
	var item_instance = find_item(item_name)
	if (item_instance == null):
		return false
	else:
		items.erase(item_instance)
		item_instance.queue_free()
		print("removed " + item_instance.item_name)
		return true

# Helper function to add item instances to inventory
func _custom_add_item(item_instance: Object):
	items.push_front(item_instance)
	self.add_child(item_instance)
	#existingItem.UpdateGraphics()

# Gets number of itemName
func get_item_count(itemName: String) -> int:
	var count = 0
	for i in range(0, items.size()):
		if (items[i].item_name == itemName):
			count += 1
	return count 

func sort():
	items.sort_custom(self, "priorityComparison")
	pass
	
func priorityComparison(a, b):
	if typeof(a) != typeof(b):
		return typeof(a) < typeof(b)
	else:
		return a.priority < b.priority
		
# Gets total weight of items
func get_total_weight() -> int:
	var total_weight = 0
	for i in range(0, items.size()):
		total_weight += items[i].weight
	return total_weight

# Gets total durability of items
func get_total_durability() -> int:
	var total_durability = 0
	for i in range(0, items.size()):
		total_durability += items[i].current_durability
	return total_durability

# Gets number of items in inventory
func get_item_size() -> int:
	return items.size()

# Debug stuff
func output():
	for i in range(0, items.size()):
		print(
		  "NAME:         " + items[i].item_name 
		+ "\nDURABILITY: " + str(items[i].durability_current)
		)
