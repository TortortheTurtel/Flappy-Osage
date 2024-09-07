extends Node2D

signal somethingTouchedMyChild
signal umbrellaCount

func _ready():
	emit_signal("umbrellaCount", get_child_count())

func _on_Umbrella5_somethingTouchedMeKyaaa():
	emit_signal("somethingTouchedMyChild")

