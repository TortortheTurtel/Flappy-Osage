extends Node2D

onready var umbrella = $Icon
var rng = RandomNumberGenerator.new()
var spin_speed = 10

func _ready():
	randomize()
	rng.randomize()
	umbrella.rotation = rng.randf_range(-1.0, 1.0)
	umbrella.scale.x = .7 + rng.randf_range(0,.3)
	umbrella.scale.y = umbrella.scale.x

func _physics_process(delta):
	umbrella.rotation_degrees += spin_speed * rng.randf_range(1,5) * delta

# warning-ignore:unused_argument
func _on_Umbrella_area_entered(area):
	queue_free()
