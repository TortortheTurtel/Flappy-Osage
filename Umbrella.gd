extends Node2D

signal somethingTouchedMyChild

func _on_Umbrella5_somethingTouchedMeKyaaa():
	emit_signal("somethingTouchedMyChild")

func _on_Umbrella_somethingTouchedMeKyaaa():
	emit_signal("somethingTouchedMyChild")

func _on_Umbrella8_somethingTouchedMeKyaaa():
	emit_signal("somethingTouchedMyChild")
