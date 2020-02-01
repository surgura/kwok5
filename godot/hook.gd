extends RigidBody2D

export(float) var throw_force = 2500
export(float) var reel_force = 200
export(NodePath) var raft_path

var caught_item = null

func _ready():
	apply_central_impulse((get_global_mouse_position() - self.global_position).normalized() * throw_force)

func _physics_process(delta):
	if caught_item != null:
		var raft = get_node(raft_path)
		var raft_direction = (caught_item.global_position - raft.global_position).normalized()
		var item_direction = (raft.global_position - caught_item.global_position).normalized()
		raft.apply_central_impulse(raft_direction * reel_force / 2 * delta)
		caught_item.apply_central_impulse(item_direction * reel_force / 2 * delta)		

func _on_catch_area_body_shape_entered(body_id, body, body_shape, area_shape):
	caught_item = body
	caught_item.is_being_reeled = true
	# remove all children of this node. we will just execute script now
	for child in get_children():
		child.queue_free()