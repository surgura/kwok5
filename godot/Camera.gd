extends Camera

var angle = 0.5*PI
var turn_speed = 3.0
var distance = 5.0

func _process(delta):
	if Input.is_action_pressed("cam_left"):
		self.angle += self.turn_speed * delta
	if Input.is_action_pressed("cam_right"):
		self.angle -= self.turn_speed * delta
		
	self.transform = Transform().translated(Vector3(
		sqrt(0.5) * self.distance * cos(self.angle),
		sqrt(0.5) * self.distance,
		sqrt(0.5) * self.distance * sin(self.angle)))
	self.look_at(Vector3(), Vector3(0.0, 1.0, 0.0))
