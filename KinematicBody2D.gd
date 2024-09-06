extends KinematicBody2D

export var jump_height = 80.0
export var jump_time_to_peak = 0.4
export var jump_time_to_descend = 0.4

onready var jump_velocity = ((2.0 * jump_height)/ jump_time_to_peak) * -1.0
onready var gravity_rise = ((-2.0 * jump_height)/ (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var gravity_fall = ((-2.0 * jump_height)/ (jump_time_to_descend * jump_time_to_descend)) * -1.0

onready var camera = $Camera2D
onready var sprite = $Sprite
onready var Happytime = $HappyTime
onready var Losetime = $LoseTime
onready var Sounds_Bling = $SoundfFx/Bling
onready var Sounds_Sweet = $SoundfFx/Sweet
onready var Sounds_Sprinkle = $SoundfFx/Sprinkle
onready var Sounds_Lose = $SoundfFx/Lose
onready var Sounds_Wep = $SoundfFx/Wep
onready var Sounds_Jump = $SoundfFx/Jump
onready var Music_KimiNiKaikisen = $SoundfFx/Kimi


var score = 0 setget score_set 
var velocity = Vector2.ZERO

var game_state = GAMING setget setGame_State,getGame_State
enum{
	PAUSE,
	LOSE,
	GAMING
}

signal game_paused
signal game_resumed

func setGame_State(state):
	if state == LOSE:
		effectSlider.visible = false
		musicSlider.visible = false
		Music_KimiNiKaikisen.stream_paused = false
		Credits_text.visible = true
		if losetype == Normal:
			Sounds_Lose.play()
	elif state == GAMING:
		Credits_text.visible = false
		effectSlider.visible = false
		musicSlider.visible = false
		Music_KimiNiKaikisen.stream_paused = false
		Sounds_Sprinkle.play()
		emit_signal("game_resumed")
	elif state == PAUSE:
		Credits_text.visible = true
		effectSlider.visible = true
		musicSlider.visible = true
		Music_KimiNiKaikisen.stream_paused = true
		Sounds_Sprinkle.play()
		emit_signal("game_paused")
	
	game_state = state

func getGame_State():
	return game_state

# Called when the node enters the scene tree for the first time.

onready var musicSlider = $Camera2D/Control/Music
onready var effectSlider = $Camera2D/Control/Effects2

func _ready():
	Music_KimiNiKaikisen.play()
	effectSlider.visible = false
	musicSlider.visible = false
	Credits_text.visible = false


func _physics_process(delta):
	match game_state:
		GAMING:
			move(delta)
			if Happytime.time_left == 0:
				pass
			elif fmod(Happytime.time_left,0.02) > .01:
				sprite.frame = 3
			elif fmod(Happytime.time_left,0.02) < .01:
				sprite.frame = 6
		LOSE:
			lose()
			move(delta)
		PAUSE:
			pause()


onready var pause_text = $Camera2D/Control/PauseText
onready var Credits_text = $Camera2D/Control/CreditsText


func pause():
	sprite.frame = 1
	pause_text.margin_top = 0
	pause_text.text = "GAME PAUSED!"


onready var score_counter = $Camera2D/Control/ScoreCount

func score_set(addScore):
	emit_signal("score")
	if addScore >= 1:
		Happytime.start()
		Sounds_Bling.play()
	score += addScore
	score_counter.text = str(score) + " out of 52" # to be changed in the future

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_accept"):
		if game_state == GAMING and Input.is_action_just_pressed("ui_accept") != true:
			setGame_State(PAUSE)
		elif game_state == PAUSE:
			pause_text.margin_top = -500
			setGame_State(GAMING)


var losetype = Normal
enum {
	Normal,
	Eaten,
	Rage,
	Win,
	PerfWin
}

func lose():
	sprite.frame = 2
	Music_KimiNiKaikisen.volume_db -= 0.2
	velocity = Vector2.ZERO
	
	if game_state == GAMING:
		Losetime.start()
		setGame_State(PAUSE)
		setGame_State(LOSE)
	
	pause_text.margin_top = 0
	match losetype:
		Normal:
			pause_text.text = "YOU LOST!" #repurpose the pause text ofc
		Eaten:
			pause_text.text = "YOU WERE EATEN!"
		Rage:
			pause_text.text = "OSAGE IS DESTROYING EVERYTHING!"
		Win:
			pause_text.text = "You Win!"
			sprite.frame = 1
		PerfWin:
			pause_text.text = "You found ALL of the Umbrellas!"
			pause_text.margin_top = 500
			pause_text.margin_left = -10
			pause_text.margin_bottom = 0
			pause_text.margin_right = 0
			sprite.frame = 1
	
	if Losetime.time_left <= 0:
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel") :
			get_tree().reload_current_scene()

signal win_time

func move(delta):
	
	velocity.y += get_gravity() * delta
	if game_state != LOSE:
		velocity.x = 100
	
	if Input.is_action_just_pressed("ui_accept"): #m1 or spacebar
		Sounds_Jump.play()
		velocity.y = jump_velocity
	
	if position.y > 300 or position.y < -300: #lose when too high or too low 
		lose()
	
	if position.x >= 19050: #this is ending condition  # will move it to a hitbox at the end of the map instead lol
		velocity.x = 0
		velocity.y = 0
		
		emit_signal("win_time")
		
		if position.y != 0:
			position.y *= .95
	
	if game_state != LOSE:
		velocity = move_and_slide(velocity, Vector2.UP)
	
	camera.global_position.y = 0 #locks camera y

func get_gravity() -> float:
	if velocity.y < 0:
		sprite.frame = 0
	else:
		sprite.frame = 3
	
	if game_state == LOSE:
		sprite.frame = 2
	
	return gravity_rise if velocity.y < 0 else gravity_fall


signal score


func _on_Scorehitbox_area_entered(_area): #Scorehitbox area
	score_set(1) 

var FXVal = 50
var MusicVal = 50

func _on_Music_value_changed(value):
	MusicVal = value
	Music_KimiNiKaikisen.volume_db = -80 + value


func _on_Effects2_value_changed(value):
	FXVal = value
	Sounds_Bling.volume_db = -80 + value
	Sounds_Sweet.volume_db = -80 + value
	Sounds_Sprinkle.volume_db = -80 + value
	Sounds_Lose.volume_db = -80 + value
	Sounds_Wep.volume_db = -80 + value
	Sounds_Jump.volume_db = -80 + value

func _on_Overseer_eaten_by_osage():
	get_node("Sprite").visible = false
	losetype = Eaten
	lose()

func _on_Overseer_osage_rage():
	get_node("Sprite").visible = false
	losetype = Rage
	lose()

func _on_Overseer_win_normal():
	losetype = Win
	lose()

func _on_Overseer_win_perfect():
	losetype = PerfWin
	lose()

func _on_Umbrella_somethingTouchedMyChild():
	score_set(1) #adds 1 score, doesn't set it to one.

func _on_Towers_somethingTouchedMyChild():
	lose()
	
