extends Node2D

var Node = preload("node.gd")
var node_grid
export(int) var width: int = 30
export(int) var height: int = 30
var dist = 50

var texture = preload("res://images/wave1.png")

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
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("makewave"):
		var relpos = get_global_mouse_position() - global_position
		relpos += Vector2(dist/2, dist/2)
		var gridpos = Vector2(int(relpos.x / self.dist), int(relpos.y / self.dist * 2.0))
		if gridpos.x < 1:
			gridpos.x = 1
		if gridpos.x >= width-1:
			gridpos.x = width-2
		if gridpos.y < 1:
			gridpos.y = 1
		if gridpos.y >= height-1:
			gridpos.y = height-2
		self.node_grid[gridpos.y][gridpos.x].height -= 200
	
	for y in range(0, height):
		for x in range(0, width):
			self.node_grid[y][x].prepare(delta)
	for y in range(0, height):
		for x in range(0, width):
			self.node_grid[y][x].assign(delta)
	update()
			
func _draw():
	for y in range(0, height / 3):
		for x in range(0, width / 2):
			#draw_circle(Vector2(x*self.dist, y*self.dist), 10+1*self.node_grid[y][x].height, Color(0.5,0.5,0.5))
			draw_texture(texture, Vector2(x * 2 *self.dist - texture.get_size().x / 2, y*3*self.dist / 2 - self.node_grid[y*3][x*2].height))
			pass