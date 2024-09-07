extends Sprite

var rng = RandomNumberGenerator.new()
var scroll_speed = 1
var enter_x = 1064
var enter_y = 226

func _ready():
##	randomize()
#	rng.randomize()
#	scroll_speed = rng.randf_range(1.0, 2.0)
#	scale.y = rng.randf_range(0.7, 2)
	pass

func Resetting():
	position.x = enter_x
	rng.randomize()
	scroll_speed = rng.randf_range(1.0, 2.0)
	scale.y = rng.randf_range(1, 2)

func _process(delta):
	position.x += -8 * scroll_speed * delta
	if position.x < -1070:
		Resetting()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
