tool
extends ImmediateGeometry

var wavetex = preload("res://images/wave1.png")
var Node = preload("node.gd")
var node_grid
export(int) var width: int = 10
export(int) var height: int = 10
var dist = 0.5

var wave_size = 0.75

func _ready():
	var wavemat = preload("res://2d3d/water/water.tres")
	self.material_override = wavemat
	
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
		self.node_grid[7][7].apply_impulse(-10.0)
	
	for y in range(height):
		for x in range(width):
			self.node_grid[y][x].prepare(delta)
	for y in range(height):
		for x in range(width):
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
	
	var cam_origin
	if Engine.is_editor_hint():
		cam_origin = Vector3(0, 100, 100)
	else:
		cam_origin = get_viewport().get_camera().transform.origin
	
	for z in range(0, height):
		for x in range(0, width):
				seed(x + self.width * z)
				var trans = Transform().translated(Vector3(offsetx + x * dist, 0, offsetz + z * dist + 0.001 * (randi() % 100)))
				trans = trans.looking_at(trans.origin + cam_origin, Vector3(0, 1, 0))
				trans = trans.translated(Vector3(0, 0.25 + node_grid[z][x].height, 0))
				
				begin(Mesh.PRIMITIVE_TRIANGLE_STRIP, wavetex)
				set_normal(trans * Vector3(0, 0, -1))
				set_uv(Vector2(0, 1))
				add_vertex(trans * Vector3(-wave_size/2, -wave_size, 0))
				set_normal(trans * Vector3(0, 0, -1))
				set_uv(Vector2(1, 1))
				add_vertex(trans * Vector3(wave_size/2, -wave_size, 0))
				set_normal(trans * Vector3(0, 0, -1))
				set_uv(Vector2(0, 0))
				add_vertex(trans * Vector3(-wave_size/2, 0, 0))
				set_normal(trans * Vector3(0, 0, -1))
				set_uv(Vector2(1, 0))
				add_vertex(trans * Vector3(wave_size/2, 0, 0))
				end()
	begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	set_color(Color(0, 1, 1))
	#self.material_override.
	var s = 40
	var h = -0.5
	set_normal(Vector3(0, -1, 0))
	add_vertex(Vector3(-s, h, -s))
	set_normal(Vector3(0, -1, 0))
	add_vertex(Vector3(s, h, -s))
	set_normal(Vector3(0, -1, 0))
	add_vertex(Vector3(-s, h, s))
	set_normal(Vector3(0, -1, 0))
	add_vertex(Vector3(s, h, s))
	end()
	