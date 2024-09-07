extends Node2D

signal somethingTouchedMyChild

func _ready():
	pass # Replace with function body.

func _myChildTowerisTouched():
	emit_signal("somethingTouchedMyChild")

