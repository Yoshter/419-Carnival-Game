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
var countingDown : bool = false

@onready var roundLabel: Label = $roundLabel
@onready var pointLabel: Label = $pointLabel

@onready var startButton: Button = $startButton

@onready var vertBar: ProgressBar = $vertBar
@onready var horBar: ProgressBar = $horBar

@onready var winMenu: Control = $winMenu

var timeSinceLastThrow = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	timeSinceLastThrow += delta
	
	if roundNum >= 4 and points >= 150:
		winMenu.set_visible(true)
		startButton.set_visible(false)
		GamesGlobal.speedPitchBeat = true
	else:
		startButton.set_visible(true)
	
	if throwDir == "vert":
		hit = false
		startButton.set_visible(false)
		vertBar.set_visible(true)
		vertCharge += pow(.45 + delta, 2)
		vertBar.value = vertCharge
		if Input.is_action_pressed("ui_accept"):
			if vertCharge >= safeRangeMin and vertCharge <= safeRangeMax:
				throwDir = "hor"
				vertBar.set_visible(false)
				vertCharge = 0
				hitSound.play(0.0)
				hit = true
				timeSinceLastThrow = 0.0
			if (vertCharge < safeRangeMin or vertCharge > safeRangeMax) and !hit:
				print("whomp")
				fail()
				
		if vertCharge >= 100:
			fail()
			print("fool")
	
	if throwDir == "hor":
		hit = null
		startButton.set_visible(false)
		horBar.set_visible(true)
		horCharge += pow(.45 + delta, 2)
		horBar.value = horCharge
		if Input.is_action_just_pressed("ui_accept") and timeSinceLastThrow > 0.01:
			if horCharge >= safeRangeMin and horCharge <= safeRangeMax:
				timeSinceLastThrow = 0.0
				hitSound.play(0.0)
				throwDir = "null"
				horBar.set_visible(false)
				horCharge = 0
				nextRound(true)
				startButton.set_visible(true)
				hit = true
			if (horCharge < safeRangeMin or horCharge > safeRangeMax) and !hit:
				print("goof")
				fail()
		if horCharge >= 100:
			fail()
	
		if throwDir == "null":
			startButton.set_visible(true)
	
	if countingDown:
		countdownLabel.set_text(str(countdown.time_left))

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
		horBar.set_visible(false)
		horCharge = 0.0
	elif throwDir == "vert":
		vertBar.set_visible(false)
		vertCharge = 0.0
	startButton.set_visible(true)
	throwDir = "null"
	nextRound(false)

func _on_start_button_pressed() -> void:
	startButton.set_visible(false)
	countingDown = true
	countdown.start()

func _on_count_down_timeout() -> void:
	throwDir = "vert"

func _on_win_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26,1.6,8.1)
	DialogueGlobal.addToEncCount("dan")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
