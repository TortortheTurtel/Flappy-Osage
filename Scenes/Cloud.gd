extends Sprite

var rng = RandomNumberGenerator.new()
var scroll_speed = 1
var enter_x = 625

func _ready():
	randomize()
	rng.randomize()
	scroll_speed = rng.randf_range(0.2, 2.0)
	scale.y = rng.randf_range(0.7, 2.5)
	position.y = rng.randf_range(-250,90)
	position.x= rng.randf_range(-625,625)

func Resetting():
	position.x = enter_x
	rng.randomize()
	scroll_speed = rng.randf_range(1.0, 2.0)
	scale.y = rng.randf_range(1, 2)

	position.y = rng.randf_range(-250,90)

func _process(delta):
	position.x += -12 * scroll_speed * delta
	if position.x < -625:
		Resetting()
	
	
