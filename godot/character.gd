extends AnimatedSprite

var rod_positions = [
	Vector2(-55.0, -50.0),
	Vector2(-54.0, -52.0),
	Vector2(-53.0, -54.0),
	Vector2(-52.0, -58.0),
	Vector2(-51.0, -62.0),
	Vector2(-50.0, -65.0),
	Vector2(-49.0, -68.0),
	Vector2(-44.0, -71.0),
	Vector2(-39.0, -74.0),
	Vector2(-44.0, -71.0),
	Vector2(-49.0, -68.0),
	Vector2(-52.0, -68.0),
	Vector2(-55.0, -66.0),
	Vector2(-59.0, -64.0),
	Vector2(-61.0, -62.0),
	Vector2(-62.0, -60.0),
	Vector2(-63.0, -58.0),
	Vector2(-65.0, -57.0),
	Vector2(-69.0, -54.0),
	Vector2(-71.0, -51.0),
	Vector2(-74.0, -49.0),
	Vector2(-75.0, -49.0),
	Vector2(-76.0, -48.0),
]

func throw_hook():
	self.play("default")
	
func release_hook():
	self.play("default", true)

func animation_finished():
	self.stop()

func look_towards(position: Vector2):
	var look_right = position.x > self.global_position.x
	self.flip_h = look_right
	
	if (look_right):
		self.offset.x = 120
	else:
		self.offset.x = -120

func get_rod_position():
	var position = self.rod_positions[self.frame]
	if (self.flip_h):
		position.x = -position.x
	return position

func get_rod_start_position():
	var position = Vector2(-1.0, 0.0)
	if (self.flip_h):
		position.x = -position.x
	return position
