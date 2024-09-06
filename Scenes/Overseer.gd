extends Sprite


#IGNORE THIS WHOLE THING PLEASE I BEG YOU :DDDD
#BUGS: DOESNT PAUSE WHEN PAUSED, i plan on just turning this whole thing into a video
#instead of whatever this is...


onready var time = 0 setget setTime
var isWinning = false

var final_score = 0
var score = 0 setget setScore
var game_state = GAMING
enum{
	GAMING,
	PAUSE
}


func _ready():
	normal()

func normal():
	position = Vector2(278,37)
	scale = Vector2(0.8,0.8)
	frame = 1

func disappear():
	frame = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if game_state == GAMING:
		setTime(delta)
	else:
		pass

func setTime(delta):
	time += delta
	if isWinning == false:
		if time >= 0 and time <= 1:
			normal()
			frame = 1
		elif time >= 9.5 and time <= 10:
			frame = 0
		elif time >= 35.5 and time <= 43.5 :
			scale.x = 2
			scale.y = 2
			frame = 1
			position.x -= 0.1
		elif time >= 44 and time <= 44.5:
			normal()
			disappear()
		elif time >= 54.5 and time <= 55.5:
			normal()
			scale.x = 2
			scale.y = 2
			frame = 0
		elif time >= 64 and time <= 65:
			frame = 1
		elif time >= 73.5 and time <= 74:
			normal()
			disappear()
		elif time >= 83 and time <= 83.5:
			normal()
		elif time >= 99.5 and time <= 100:
			disappear()
		elif time >= 109.5  and time <= 110.5:
			normal()
			scale.x = 2
			scale.y = 2
		elif time >= 118.5 and time <= 119.5:
			normal()
			disappear()
		elif time >= 146.5 and time <= 147.5:
			normal()
			scale.x = 2
			scale.y = 2
			frame = 0
		elif time >= 156.5 and time <= 157:
			frame = 1
			rotation += -0.6
		elif time >= 157 and time <= 158:
			rotation = 0
		elif time >= 158 and time <= 158.5:
			frame = 0
		elif time >= 166 and time <= 166.5:
			frame = 1
		elif time >= 175 and time <= 184.5:
			position.y = -325
			position.x -= 0.1
		elif time >= 185 and time <= 185.5:
			disappear()
		elif time >= 189 and time <= 190:
			normal()
			final_score = score
	else:
		frame = 2
		if final_score == 0:
			position.x -= 30 * sin(time * 5)
			if sin(time * 5) > 0:
				set_flip_h(false)
			else:
				set_flip_h(true)
			if position.x <= -300:
				emit_signal("osage_rage")
		
		if final_score <= 39 and final_score > 0 and umbrella_death >= final_score:
			if position.x >= -120:
				position.x -= 10
			if position.x <= -120:
				emit_signal("eaten_by_osage")
				if fmod(floor(time), 2) == 1:
					frame = 1
				else:
					frame = 2
		if final_score > 39 and final_score < 52 and umbrella_death >= final_score:
			frame = 0
			emit_signal("win_normal")
		if final_score == 52 and umbrella_death >= final_score:
			frame = 1
			if scale <= Vector2(0.3,0.3):
				scale *= 0.95
			emit_signal("win_perfect")

signal win_perfect
signal win_normal
signal osage_rage
signal eaten_by_osage
signal score_reduced

func setScore(i): #finalScore
	if i == -1:
		emit_signal("score_reduced")
	score += i



func _on_Osage_game_paused():
	game_state = PAUSE
func _on_Osage_game_resumed():
	game_state = GAMING
func _on_Osage_game_reset():
	time = 0 
	score = 0
	final_score = 0
	umbrella_death = 0
	isWinning = false

func _on_Osage_score():
	score += 1 #don't turn to setget

func _on_Osage_win_time():
	isWinning = true
	if score > 0: #turn to 0 but with style
		setScore(-1)

var umbrella_death = 0

func _on_Umbrella_fall_umbrella_death():
	umbrella_death += 1
