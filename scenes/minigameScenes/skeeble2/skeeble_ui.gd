extends Control

var throwPower : float = 0.0
@onready var throwPowerBar: ProgressBar = $throwPowerBar
var isAdding : bool = true
var isThrowing : bool = false
var roundNum : int = 1
@onready var nextRoundButton: Button = $nextRoundButton

func _process(delta: float) -> void:
	if !isThrowing:
		nextRoundButton.set_visible(true)
		
	if isThrowing:
		nextRoundButton.set_visible(false)
		if isAdding:
			throwPower += delta * 30
		if Input.is_action_just_pressed("ui_accept"):
			if throwPower >= 5 and throwPower <= 20:
				print("GOOMAH")
				endRound()
			elif throwPower >= 30 and throwPower <= 45:
				print("TANKO")
				endRound()
			elif throwPower > 45 and throwPower < 55:
				print("SHLUCK")
				endRound()
			elif throwPower >= 55 and throwPower <= 70:
				print("BUPKIS")
				endRound()
			elif throwPower >= 80 and throwPower <= 95:
				print("HEYOO")
				endRound()
			else:
				pass
		throwPowerBar.set_value(throwPower)
		if throwPower >= 100:
			#fail music playes
			endRound()

func endRound() -> void:
	roundNum += 1
	isThrowing = false
	throwPower = 0.0

func _on_next_round_button_pressed() -> void:
	isThrowing = true
