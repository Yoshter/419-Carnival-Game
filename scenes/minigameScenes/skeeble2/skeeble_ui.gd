extends Control

var throwPower : float = 0.0
@onready var throwPowerBar: ProgressBar = $greenRects/throwPowerBar

var isAdding : bool = true
var isThrowing : bool = false
var roundNum : int = 1
@onready var nextRoundButton: Button = $nextRoundButton
@onready var winMenu: Control = $winMenu
@onready var prizeButton: Button = $winMenu/prizeButton
@onready var skeebleAnim: AnimatedSprite2D = $skeebleAnim
@onready var retryMenu: Control = $retryMenu
@onready var retryButton: Button = $retryMenu/retryButton
@onready var score: Label = $score
@onready var roll = $Roll

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _process(delta: float) -> void:
	
	score.set_text("SCORE: " + str("%04d" % GamesGlobal.skeebleScore))
	
	if !isThrowing:
		nextRoundButton.set_visible(true)
		
	if isThrowing:
		nextRoundButton.set_visible(false)
		if isAdding:
			throwPower += delta * 90
		if Input.is_action_just_pressed("ui_accept"):
			if throwPower >= 5 and throwPower <= 20:
				GamesGlobal.skeebleScore += 10
				skeebleAnim.play("outerLeft")
				endRound()
				roll.play(0.0)
			elif throwPower >= 30 and throwPower <= 45:
				GamesGlobal.skeebleScore += 50
				skeebleAnim.play("innerLeft")
				roll.play(0.0)
				endRound()
			elif throwPower > 45 and throwPower < 55:
				GamesGlobal.skeebleScore += 100
				skeebleAnim.play("center")
				roll.play(0.0)
				endRound()
			elif throwPower >= 55 and throwPower <= 70:
				GamesGlobal.skeebleScore += 50
				skeebleAnim.play("innerRight")
				roll.play(0.0)
				endRound()
			elif throwPower >= 80 and throwPower <= 95:
				skeebleAnim.play("outerRight")
				GamesGlobal.skeebleScore += 10
				roll.play(0.0)
				endRound()
			else:
				endRound()
		throwPowerBar.set_value(throwPower)
		if throwPower >= 100:
			#fail music playes. no it doesnt lmaooo what i didnt make that -bren
			endRound()
	if roundNum == 4 and GamesGlobal.skeebleScore >= 175:
		nextRoundButton.set_visible(false)
		winMenu.set_visible(true)
	if roundNum >= 4:
		print("round4")
		if GamesGlobal.skeebleScore < 175:
			print(GamesGlobal.skeebleScore)
			nextRoundButton.set_visible(false)
			retryMenu.set_visible(true)

func endRound() -> void:
	roundNum += 1
	isThrowing = false
	throwPower = 0.0

func _on_next_round_button_pressed() -> void:
	isThrowing = true

func _on_prize_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26.46,1.266,-5.309)
	GamesGlobal.skeebleBeat = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")

func _on_retry_button_pressed() -> void:
	isThrowing = false
	throwPower = 0.0
	roundNum = 1
	GamesGlobal.skeebleScore = 0
	retryMenu.set_visible(false)
