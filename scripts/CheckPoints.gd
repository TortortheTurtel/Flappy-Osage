extends Node2D

signal checkPointTouched
var checkPointArray = []
var umbrellaArray = []
var scoreCounted = 0 
var scorestored = []

func _on_checkPointArea2D_area_entered(_area):
	
	
	# when oge touch, reset scoreCounted, assign score into the singleton
	# 
	
	pass # Replace with function body.


func _on_Umbrella_umbrellaPositions(umbrellaPosXArray):
	
	# get childpos -> array[]
	# get umbrellaposX
	#
	
	pass # Replace with function body.


func _on_Osage_score():
	scoreCounted += 1 
	
	pass # Replace with function body.
