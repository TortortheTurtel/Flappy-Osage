extends Sprite

signal umbrella_death
var fallingUmbrella = preload("res://umbrella_falling.tscn")
var umbrella_fall_scene = fallingUmbrella.instance()

func _ready():
	umbrella_fall_scene = fallingUmbrella.instance()
	get_node("Umbrella").queue_free()

func _on_Overseer_score_reduced():
	
	umbrella_fall_scene = fallingUmbrella.instance()
	add_child(umbrella_fall_scene)
	umbrella_fall_scene.connect("die", self, "_on_umbrella_die")


func _on_Umbrella_die():
	emit_signal("umbrella_death")
