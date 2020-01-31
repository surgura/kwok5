extends KinematicBody2D

var direction
var speed = 5

func _ready():
	direction = (get_global_mouse_position() - self.global_position).normalized()
	
func _physics_process(delta):
	move_and_collide(direction * speed)