extends Node2D

onready var new_all_umbrellas = $umbrellas
var all_umbrellas = preload("res://umbrellas.tscn")
# Called when the node enters the scene tree for the first time.



func _on_Osage_game_reset():
	new_all_umbrellas.queue_free()
	new_all_umbrellas = all_umbrellas.instance()
	add_child(new_all_umbrellas)
