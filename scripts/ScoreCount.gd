extends Label

func _on_Osage_umbrella_count_from_thing(UmbrellaCount):
	text = "0 out of " +  str(UmbrellaCount) + "\nBut you only need 40" #might be unneeded text tbh, cos you can always check point to get more umbrellas
