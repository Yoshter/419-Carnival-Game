extends Node2D

@export var ballNum : int = 1
var power : float = 0.0
@onready var powerBar: ProgressBar = $"../powerBar"
var hasThrown : bool = false
var roundIsOver : bool = false
var roundDelayed : bool = false
var leftPos : int = 0
var rightPos : int = 0
@onready var roundDelayTimer: Timer = $"../roundDelayTimer"

func _ready() -> void:
	add_to_group("ball")

func _process(delta: float) -> void:
	power -= delta * 2
	if ballNum == GamesGlobal.skeebleBallNum:
		if Input.is_action_pressed("ui_accept") and power < 100 and !hasThrown:
			power += delta * 75
			powerBar.set_value(power)
		if Input.is_action_just_released("ui_accept") and !hasThrown:
			hasThrown = true
	if hasThrown and !roundDelayed:
		roundDelayTimer.start(0.0)
		roundDelayed = true
	if roundIsOver:
		print("over")
		hasThrown = false
		roundDelayed = false
		roundIsOver = false
		power = 0.0
		powerBar.set_value(power)
		GamesGlobal.skeebleBallNum += 1

func _physics_process(delta: float) -> void:
	if !hasThrown:
		if Input.is_action_pressed("left") and leftPos < 3:
			position.x -= delta * 75
			leftPos += 1 * delta
			rightPos -= 1 * delta
		if Input.is_action_pressed("right")and rightPos < 3:
			position.x += delta * 75
			rightPos += 1 * delta
			leftPos -= 1 * delta 
	if hasThrown:
		position.y -= pow((power / 18), 2) - pow(delta, 2)

func _on_round_delay_timer_timeout() -> void:
	roundIsOver = true
