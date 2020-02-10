extends ImmediateGeometry

var Node = preload("node.gd")
var node_grid
export(int) var width: int = 40
export(int) var height: int = 40
var dist = 0.5

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
	"""
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
	"""
	
	if Input.is_action_just_pressed("makewave"):
		self.node_grid[20][20].apply_impulse(-10.0)
	
	for y in range(0, height):
		for x in range(0, width):
			self.node_grid[y][x].prepare(delta)
	for y in range(0, height):
		for x in range(0, width):
			self.node_grid[y][x].assign(delta)
	self.draw()
			
func draw():
	clear()
	
	begin(Mesh.PRIMITIVE_LINES)
	
	var offsetx = -0.5 * width * dist
	var offsetz = -0.5 * height * dist
	for z in range(0, height):
		for x in range(0, width):
			if x != width-1:
				add_vertex(Vector3(offsetx + x * dist, node_grid[z][x].height, offsetz + z * dist))
				add_vertex(Vector3(offsetx + (x+1) * dist, node_grid[z][x+1].height, offsetz + z * dist))
			if z != height-1:				
				add_vertex(Vector3(offsetx + x * dist, node_grid[z][x].height, offsetz + z * dist))
				add_vertex(Vector3(offsetx + x * dist, node_grid[z+1][x].height, offsetz + (z+1) * dist))
	
	end()