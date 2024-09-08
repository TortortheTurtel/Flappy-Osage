extends Node2D

signal somethingTouchedMyChild
signal umbrellaCount
signal umbrellaPositions
var UmbrellaXPosArray = []

func _ready():
	emit_signal("umbrellaCount", self.get_child_count())


func _on_Umbrella_position(UmbrellaXPos): 
	UmbrellaXPosArray.append(UmbrellaXPos)
	
	if UmbrellaXPosArray.size() == self.get_child_count(): #I can't store self.get_child_count() as variable without it turning to 0 :P
		UmbrellaXPosArray.sort()
		emit_signal("umbrellaPositions", UmbrellaXPosArray) # send to checkpoints

func _on_Umbrella_somethingTouchedMeKyaaa(): #relays the signal to player after receiving it
	emit_signal("somethingTouchedMyChild") 
