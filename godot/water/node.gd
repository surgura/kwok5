var height: float
var mass: float = 0.5
var _neighbours
var _force
var _velocity: float = 0.0
var spring_constant: float = 20.0
var spring_constant_base: float = 20.0
var damp = 2.0

func _init(start_height: float) -> void:
	self.height = start_height
	self._neighbours = []
	
func add_neighbour(neighbour) -> void:
	self._neighbours.append(neighbour)
	
func prepare(_delta: float) -> void:
	self._force = 0
	for neighbour in self._neighbours:
		self._force += self.spring_constant * (neighbour.height - self.height)
	self._force += self.spring_constant_base * (0.0 - self.height)
	
func assign(delta: float) -> void:
	self._velocity += delta * self._force / self.mass
	self._velocity -= delta * self.damp * self._velocity
	self.height += delta * self._velocity
