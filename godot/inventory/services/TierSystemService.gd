extends Node

var current_tier = 1
var maximum_tier = 2

var requirements_map = {
	1: { "wooden_plank": 1},
	2: { "wooden_plank": 2}
}

# Given a tier, finds required requirements
func find_required_items(tier: int):
	if requirements_map.has(tier):
		return requirements_map[tier]
	else:
		return {}
		
# Returns true if all tier requirements are cleared
func is_all_tiers_cleared():
	return current_tier > maximum_tier

# Returns current tier
func get_current_tier():
	return current_tier

# Updates tier to new value
func update_current_tier(new_tier_value: int):
	current_tier = new_tier_value

# Deliver items
# Goes over your inventory and matches the requirements
# Automatically removes everything you have if the requirements are met
func deliver(inventory: Object) -> int:
	var required_items = find_required_items(current_tier)
	if (required_items.empty() || required_items == null):
		print("Tier does not exist!")
		return -1 # Tier does not exist
	else:
		var inventory_count_prev = inventory.get_item_count()
		var dict_key_array = Array(required_items.keys())
		#var dict_values_array = Array(required_items.values())
		
		# Loop over all keys
		for i in range(0, dict_key_array.size()):
			var current_item_name = dict_key_array[i];
			var found_item = inventory.find_item(current_item_name)
			
			# If you have the item in your inventory
			if (found_item != null):
				# Remove the items in your inventory.. one by one basically
				var items_count = inventory.get_item_count(found_item.item_name)
				var required_number_of_resources = required_items[dict_key_array[i]]
				while (required_number_of_resources <= items_count):
					inventory.remove_item(found_item.item_name)
					# Remove requirements one by one from the tiersystem if player has enough resources
					required_items[dict_key_array[i]] -= 1
					if (required_items[dict_key_array[i]] <= 0):
						required_items.erase(dict_key_array[i])
						print("[RewardsDelivery] Removed  " + dict_key_array[i])
						break
		#print("---")
		#inventory.output()
		if (required_items.size() == 0):
			update_current_tier(current_tier + 1)
			print("Next Tier!! :D  ", current_tier)
			return 3 # Next tier! Gratz!
		elif (inventory_count_prev != required_items.size()):
			return 1 # Partially delivered
		else:
			return 2 # Nothing delivered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
