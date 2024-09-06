extends Node2D

signal windowTouch

func _ready():
	self.connect("windowTouch", self.get_parent(), "_myChildTowerisTouched")
	return 0

func _on_Area2D_area_entered(_area):
	emit_signal("windowTouch")
