extends Control

var roundNum = 1
var throwDir = "null"
var points = 0

var vertCharge : float = 0
var horCharge : float = 0

var safeRangeMin = 35
var safeRangeMax = 65

var hit = false

@onready var failSound: AudioStreamPlayer = $failSound
@onready var hitSound: AudioStreamPlayer = $hitSound

@onready var countdown: Timer = $countDown
@onready var countdownLabel: Label = $countdownLabel
var countingDown : bool = true

@onready var roundLabel: Label = $roundLabel
@onready var pointLabel: Label = $pointLabel

@onready var startButton: Button = $startMenu/startButton
@onready var startMenu: TextureRect = $startMenu

@onready var vertBarNode: Control = $vertBarNode
@onready var horBarNode: Control = $horbarNode

@onready var vertBar: ProgressBar = $vertBarNode/vertBar
@onready var horBar: ProgressBar = $horbarNode/horBar

@onready var goAgainButton: Button = $goAgainButton
@onready var retryButton: Button = $retry

@onready var winMenu: Control = $winMenu
@onready var throwSound = $ThrowSound
@onready var winSound = $WinSound

@onready var wrongThrows: AnimatedSprite2D = $sprites/WrongThrows
@onready var rightThrows: AnimatedSprite2D = $sprites/RightThrows

var timeSinceLastThrow = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	timeSinceLastThrow += delta
	
	if roundNum >= 4 and points >= 150 and !GamesGlobal.speedPitchBeat:
		winMenu.set_visible(true)
		winSound.play(0.0)
		startButton.set_visible(false)
		goAgainButton.set_visible(false)
		GamesGlobal.speedPitchBeat = true
	
	if roundNum >= 4 and points < 150:
		goAgainButton.set_visible(false)
		retryButton.set_visible(true)
	
	if throwDir == "vert":
		hit = false
		startButton.set_visible(false)
		vertBarNode.set_visible(true)
		vertCharge += pow(.90 + delta, 2)
		vertBar.value = vertCharge
		if Input.is_action_pressed("ui_accept"):
			if vertCharge >= safeRangeMin and vertCharge <= safeRangeMax:
				throwDir = "hor"
				vertBarNode.set_visible(false)
				vertCharge = 0
				hitSound.play(0.0)
				hit = true
				timeSinceLastThrow = 0.0
			if vertCharge > safeRangeMax and !hit:
				wrongThrows.set_visible(true)
				wrongThrows.play("right")
				fail()
			elif vertCharge < safeRangeMin and !hit:
				wrongThrows.set_visible(true)
				wrongThrows.play("left")
				#print("goof")
				fail()
		if vertCharge >= 100:
			fail()
			#print("fool")
	
	if throwDir == "hor":
		hit = null
		startButton.set_visible(false)
		horBarNode.set_visible(true)
		horCharge += pow(.90 + delta, 2)
		horBar.value = horCharge
		if Input.is_action_just_pressed("ui_accept") and timeSinceLastThrow > 0.01:
			if horCharge >= safeRangeMin and horCharge <= safeRangeMax:
				rightThrows.set_visible(true)
				rightThrows.play("center")
				timeSinceLastThrow = 0.0
				hitSound.play(0.0)
				throwSound.play(0.0)
				throwDir = "null"
				horBarNode.set_visible(false)
				horCharge = 0
				nextRound(true)
				goAgainButton.set_visible(true)
				hit = true
			if horCharge > safeRangeMax and !hit:
				wrongThrows.set_visible(true)
				wrongThrows.play("right")
				fail()
			elif horCharge < safeRangeMin and !hit:
				wrongThrows.set_visible(true)
				wrongThrows.play("left")
				print("goof")
				fail()
		if horCharge >= 100:
			fail()
	
		if throwDir == "null":
			goAgainButton.set_visible(true)
	
	if countingDown:
		countdownLabel.set_visible(true)
		countdownLabel.set_text(str(round(countdown.time_left)))
	else:
		countdownLabel.set_visible(false)

func nextRound(goodThrow : bool) -> void:
	safeRangeMin += 5
	safeRangeMax -= 5
	if goodThrow:
		match roundNum:
			1:
				points += 50
			2:
				points += 100
			3: 
				points += 200
	roundNum += 1
	roundLabel.set_text(str(roundNum))
	pointLabel.set_text(str(points))

func fail() -> void:
	failSound.play(0.0)
	if throwDir == "hor":
		horBarNode.set_visible(false)
		horCharge = 0.0
	elif throwDir == "vert":
		vertBarNode.set_visible(false)
		vertCharge = 0.0
	goAgainButton.set_visible(true)
	throwDir = "null"
	nextRound(false)

func _on_start_button_pressed() -> void:
	startMenu.set_visible(false)
	countingDown = true
	countdown.start()

func _on_go_again_button_pressed() -> void:
	goAgainButton.set_visible(false)
	countingDown = true
	countdown.start()
	rightThrows.set_visible(false)
	wrongThrows.set_visible(false)

func _on_retry_pressed() -> void:
	points = 0
	roundNum = 0
	get_tree().change_scene_to_file("res://scenes/minigameScenes/speedPitch/speed_pitch.tscn")

func _on_count_down_timeout() -> void:
	throwDir = "vert"
	countingDown = false

func _on_win_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26,1.6,8.1)
	if GamesGlobal.checkBeatGame("speedPitch"):
		DialogueGlobal.addToEncCount("dan")
		DialogueGlobal.objEncCount += 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")


func _on_exit_pressed():
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26,1.6,8.1)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
