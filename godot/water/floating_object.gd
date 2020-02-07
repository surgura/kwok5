extends RigidBody2D

export(NodePath) var water_path: NodePath
var size: float = 20.0
var water
var height = 0
var velocity = 0
var forceconst = 80.0
var gravity = 200.0
var _mass = 1.0
var damp = 1.0

func _ready():
	self.water = get_node(self.water_path)

func _process(delta):
	var relpos = self.global_position - self.water.global_position
	relpos += Vector2(self.size/2, self.size/2)
	var gridpos = Vector2(int(relpos.x / self.water.dist), int(relpos.y / self.water.dist))
	var diff = self.water.node_grid[gridpos.y][gridpos.x].height - self.height
	if diff > 0:
		self.velocity += delta * self.forceconst * diff
	self.velocity -= delta * gravity
	self.velocity -= self.velocity * self.damp * delta
	self.height += delta * self.velocity
	update()
	
func _draw():
	draw_rect(Rect2(-Vector2(self.size, self.size)/2 - Vector2(0, self.global_position.y/2) - Vector2(0, self.height), Vector2(self.size, self.size)), Color.red)