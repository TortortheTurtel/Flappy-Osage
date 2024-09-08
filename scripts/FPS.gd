extends Label


# Called when the node enters the scene tree for the first time.
# Remove this once ready for export lol

func _process(_delta):
	text = "FPS: " + str(Engine.get_frames_per_second())
