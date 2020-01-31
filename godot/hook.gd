extends KinematicBody2D

var direction
var speed = 100
var caught_item = null
export(NodePath) var raft_path

func _ready():
	direction = (get_global_mouse_position() - self.global_position).normalized()

func _physics_process(delta):
	#if hit_item:
	#	direction = (get_node(raft).global_position - self.global_position).normalized()
	
	if caught_item == null:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			caught_item = collision.get_collider()
			get_node("./collision_shape").disabled = true
	else:
		var raft = get_node(raft_path)
		var raft_weight = raft.weight
		var item_weight = caught_item.weight
		var ratio_raft = float(item_weight) / float(raft_weight + item_weight)
		var ratio_item = 1-ratio_raft
		var raft_direction = (caught_item.global_position - raft.global_position).normalized()
		var item_direction = (raft.global_position - caught_item.global_position).normalized()
		raft.move_and_collide(raft_direction * ratio_raft * speed * delta)
		caught_item.move_and_collide(item_direction * ratio_item * speed * delta)
		