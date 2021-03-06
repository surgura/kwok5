extends RigidBody2D

export(float) var throw_force = 2500
export(float) var reel_force = 200
export(NodePath) var raft_path

var release_force = 500
var is_releasing = false

var caught_item = null
var caught_body = null

func _ready():
	apply_central_impulse((get_global_mouse_position() - self.global_position).normalized() * throw_force)

func _process(_delta):
	update()

func _physics_process(delta):
	if caught_item != null:
		var raft = get_node(raft_path)
		var raft_direction = (caught_body.global_position - raft.global_position).normalized()
		var item_direction = (raft.global_position - caught_item.global_position).normalized()
		raft.apply_central_impulse(raft_direction * reel_force / 2 * delta)
		caught_item.apply_central_impulse(item_direction * reel_force / 2 * delta)
	
	if (is_releasing):
		var to_raft = get_node(raft_path).global_position - self.global_position
		apply_central_impulse(to_raft.normalized() * release_force)
		if (to_raft.length() < 80.0):
			get_node(raft_path).catch_hook()
	
func _draw():
	#var begin: Position2D = get_node("fishline_begin")
	var end = Vector2()
	if caught_item != null:
		end = caught_body.global_transform.origin - global_transform.origin
	var begin = get_node(raft_path).get_node("fishline_begin").global_transform.origin - global_transform.origin
	draw_line(begin, end, Color(255, 220, 160), 1.0, true)
	
	if (get_node("sprite")):
		get_node("sprite").rotation = (end - begin).angle() - PI / 2

func _on_catch_area_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	caught_body = body.shape_owner_get_owner(body.shape_find_owner(_body_shape))
	caught_item = body
	caught_item.is_being_reeled = true
	# remove all children of this node. we will just execute script now
	for child in get_children():
		child.queue_free()
		
func can_release():
	return (caught_item == null) or caught_item.can_release_hook
	
func release():
	if caught_item != null:
		caught_item.is_being_reeled = false
		caught_item = null
		caught_body = null
		get_node(raft_path).catch_hook()
		
	is_releasing = true
