extends Sprite

onready var rng = RandomNumberGenerator.new()
onready var spin_speed = 10
onready var fall_speed = 30


func _ready():
	randomize()
	rng.randomize()
	rotation = rng.randf_range(-1.0, 1.0)
	scale.x = .7 + rng.randf_range(0,.3)
	scale.y = scale.x
#	position.y = rng.randf_range(-310,-600)
#	position.x = rng.randf_range(-550,550)

func _process(delta):
	rotation_degrees += spin_speed * rng.randf_range(1,5) * delta

signal somethingTouchedMeKyaaa

func _on_Area2D_area_entered(_area): #umbrella touched
	self.connect("somethingTouchedMeKyaaa", self.get_parent(), "_on_Umbrella5_somethingTouchedMeKyaaa")
	emit_signal("somethingTouchedMeKyaaa")
	queue_free()

