extends RigidBody2D

var hook_scene = preload("res://hook.tscn")
var hook_instance = null
export(NodePath) var inventory_path

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("throw_hook"):
		interact_hook()


func _on_raft_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	var inventory = get_node(inventory_path)
	#var item = body.maybe_get_item(inventory)
	# TODO add item to inventory
	#var damage = body.get_damage(self.mass, self.get_linear_velocity(), inventory)
	# TODO apply damage to inventory
	body.on_hit_raft()
	self.release_hook()

func interact_hook():
	if hook_instance == null:
		throw_hook()
	else:
		if hook_instance.can_release_hook:
			release_hook()

func throw_hook():
	hook_instance = hook_scene.instance()
	hook_instance.raft_path = self.get_path()
	get_node("../").add_child(hook_instance)

func release_hook():
	hook_instance.queue_free()
	hook_instance = null