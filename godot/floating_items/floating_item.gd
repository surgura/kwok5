extends RigidBody2D

export(bool) var destroy_on_impact : bool = false
export(bool) var can_release_hook : bool = false
export(bool) var is_being_reeled : bool = false

# The damage this item deals to the raft.
func get_damage(ship_weight : float, ship_velocity : Vector2, inventory : Object) -> float:
	return get_weight_damage_factor(ship_weight) * get_speed_damage_factor((ship_velocity - get_linear_velocity()).length()) * get_base_damage()

# Default weight damage factor. Function starting at 1 with asymptote at 2.
func get_weight_damage_factor(ship_weight : float) -> float:
	return 1 + (1 - exp(-ship_weight))

# Default impact speed damage factor.
func get_speed_damage_factor(impact_speed : float) -> float:
	return 1 + (impact_speed / 10)

# Base damage.
func get_base_damage():
	return 1

# What should happen when the item collides with the raft.
func on_hit_raft() -> void:
	if (destroy_on_impact):
		self.queue_free()
	
# Returns an inventory item or null.
func maybe_get_item(inventory : Object):
#	if (!can_pickup(inventory_items)):
#		return null
	
	return get_item()

func can_pickup(inventory_items: Array) -> bool:
	return false

func get_item():
	return null
