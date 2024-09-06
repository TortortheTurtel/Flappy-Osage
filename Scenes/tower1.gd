extends Node2D

signal windowTouch
var isVisible = false

func _ready():
	var _unused_var = self.connect("windowTouch", self.get_parent(), "_myChildTowerisTouched")
	return 0

func _on_Area2D_area_entered(_area):
	emit_signal("windowTouch")


func _on_VisibilityEnabler2D_viewport_exited(_viewport):
	queue_free()



