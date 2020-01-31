extends KinematicBody2D

var direction
var speed = 500
var hit_item = false
export(NodePath) var return_node

func _ready():
	direction = (get_global_mouse_position() - self.global_position).normalized()

func _physics_process(delta):
	if hit_item:
		direction = (get_node(return_node).global_position - self.global_position).normalized()
	
	if move_and_collide(direction * speed * delta):
		hit_item = true