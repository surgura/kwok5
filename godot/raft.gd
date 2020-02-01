extends RigidBody2D

var hook_scene = preload("res://hook.tscn")
var hook_instance = null
export(NodePath) var inventory_path

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("throw_hook"):
		interact_hook()
		
	var character = get_node("character")
	if hook_instance != null:
		character.look_towards(hook_instance.global_transform.origin)
		get_node("fishline_begin").transform.origin = character.get_rod_position()
	else:
		character.look_towards(self.get_global_mouse_position())

func _on_raft_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	var inventory = get_node(inventory_path)
	var item = body.maybe_get_item(inventory)
	if item:
		inventory.add_item(item)
	var damage = body.get_damage(self.mass, self.get_linear_velocity(), inventory)
	inventory.take_damage(damage)
	body.on_hit_raft()
	if hook_instance != null and hook_instance.caught_item == body:
		self.release_hook()

func interact_hook():
	if hook_instance == null:
		throw_hook()
	else:
		if hook_instance.can_release():
			release_hook()

func throw_hook():
	var character = get_node("character")
	hook_instance = hook_scene.instance()
	hook_instance.raft_path = self.get_path()
	hook_instance.global_transform.origin = self.global_transform.origin + character.get_rod_start_position()
	get_node("../").add_child(hook_instance)
	character.throw_hook()

func release_hook():
	if hook_instance != null:
		hook_instance.release()
		get_node("character").release_hook()

func catch_hook():
	if hook_instance != null:
		hook_instance.queue_free()
		hook_instance = null
	
