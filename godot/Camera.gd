tool
extends Camera

export(float) var angle: float = 0.5*PI
export(float) var turn_speed: float = 3.0
export(float) var distance: float = 5.0
export(float) var in_speed: float = 3.0

func _process(delta):
	if Input.is_action_pressed("cam_left"):
		self.angle += self.turn_speed * delta
	if Input.is_action_pressed("cam_right"):
		self.angle -= self.turn_speed * delta
	self.angle = fmod(self.angle, 2 * PI)
	
	if Input.is_action_pressed("cam_in"):
		self.distance -= self.in_speed * delta
	if Input.is_action_pressed("cam_out"):
		self.distance += self.in_speed * delta
		
	self.transform = Transform().translated(Vector3(
		sqrt(0.5) * self.distance * cos(self.angle),
		sqrt(0.5) * self.distance,
		sqrt(0.5) * self.distance * sin(self.angle)))
	self.look_at(Vector3(), Vector3(0.0, 1.0, 0.0))
