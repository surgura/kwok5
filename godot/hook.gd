extends RigidBody2D

var direction
var speed = 100
var caught_item = null
export(NodePath) var raft_path

func _ready():
	apply_central_impulse((get_global_mouse_position() - self.global_position).normalized() * speed)

func _physics_process(delta):
	if caught_item != null:
		var raft = get_node(raft_path)
		var raft_weight = raft.weight
		var item_weight = caught_item.weight
		var ratio_raft = float(item_weight) / float(raft_weight + item_weight)
		var ratio_item = 1-ratio_raft
		var raft_direction = (caught_item.global_position - raft.global_position).normalized()
		var item_direction = (raft.global_position - caught_item.global_position).normalized()
		
		raft.apply_central_impulse(raft_direction * ratio_item * speed * delta)
		caught_item.apply_central_impulse(item_direction * ratio_item * speed * delta)		

func _on_catch_area_body_shape_entered(body_id, body, body_shape, area_shape):
	caught_item = body
	# remove all children of this node. we will just execute script now
	for child in get_children():
		child.queue_free()
