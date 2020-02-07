extends Node2D

var Node = preload("node.gd")
var node_grid
export(int) var width: int = 20
export(int) var height: int = 20
var dist = 50

func _ready():
	self.node_grid = []
	for y in range(height):
		self.node_grid.append([])
		for _x in range(width):
			self.node_grid[y].append(Node.new(0))
			
	for y in range(1, height-1):
		for x in range(1, width-1):
			if y != 0:
				self.node_grid[y][x].add_neighbour(self.node_grid[y-1][x])
			if y != height-1:
				self.node_grid[y][x].add_neighbour(self.node_grid[y+1][x])
			if x != 0:
				self.node_grid[y][x].add_neighbour(self.node_grid[y][x-1])
			if x != width-1:
				self.node_grid[y][x].add_neighbour(self.node_grid[y][x+1])
			
	#self.node_grid[0][0].height = 10.0
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("makewave"):
		var relpos = get_global_mouse_position() - global_position
		relpos += Vector2(dist/2, dist/2)
		var gridpos = Vector2(int(relpos.x / self.dist), int(relpos.y / self.dist))
		#print(gridpos)
		self.node_grid[gridpos.y][gridpos.x].height -= 10
	
	for y in range(0, height):
		for x in range(0, width):
			self.node_grid[y][x].prepare(delta)
	for y in range(0, height):
		for x in range(0, width):
			self.node_grid[y][x].assign(delta)
	update()
			
func _draw():
	for y in range(0, height):
		for x in range(0, width):
			draw_circle(Vector2(x*self.dist, y*self.dist), 10+5*self.node_grid[y][x].height, Color(1,1,1))
