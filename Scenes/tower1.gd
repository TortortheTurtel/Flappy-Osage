extends Node2D

signal windowTouch

func _on_Area2D_area_entered(area):
	emit_signal("windowTouch")

