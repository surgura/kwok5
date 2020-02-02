extends RigidBody2D

enum Trigger {
	IMPACT,
	CATCH,
	NEVER	
}

export(Trigger) var destroy_trigger = Trigger.IMPACT
export(Trigger) var pickup_trigger = Trigger.CATCH
export(bool) var can_release_hook : bool = false
export(bool) var is_being_reeled : bool = false
export(float) var base_damage: float = 0.0
export(String) var item: String = ""
export(String) var display_text = ""

func _init():
	self.z_as_relative = false

func _process(_delta):
	self.z_index = self.global_position.y / 10.0

# The damage this item deals to the raft.
func get_damage(ship_weight : float, ship_velocity : Vector2, inventory : Object) -> float:
	return get_weight_damage_factor(ship_weight) * get_speed_damage_factor((ship_velocity - get_linear_velocity()).length()) * base_damage

# Default weight damage factor. Function sta4rting at 1 with asymptote at 2.
func get_weight_damage_factor(ship_weight : float) -> float:
	return 1 + (1 - exp(-ship_weight))

# Default impact speed damage factor.
func get_speed_damage_factor(impact_speed : float) -> float:
	#return impact_speed / 250
	return 1.0#TODO

# What should happen when the item collides with the raft.
func on_hit_raft() -> void:
	if display_text != "":
		var textbox = get_tree().get_root().find_node("textbox", true, false)
		textbox.show_stuff(display_text, get_node("sprite").texture)
	if destroy_trigger == Trigger.IMPACT or (destroy_trigger == Trigger.CATCH and is_being_reeled):
		self.queue_free()
	
# Returns an inventory item or null.
func maybe_get_item(inventory : Object):
	if pickup_trigger == Trigger.IMPACT or (pickup_trigger == Trigger.CATCH and is_being_reeled):
		return item

