extends StaticBody2D

@export var ballNum : int = 1
var power : float = 0.0
@onready var powerBar: ProgressBar = $"../powerBar"
var hasThrown : bool = false

func _ready() -> void:
	add_to_group("ball")

func _process(delta: float) -> void:
	power -= delta * 2
	if ballNum == GamesGlobal.skeebleBallNum:
		if Input.is_action_pressed("ui_accept") and power < 100 and !hasThrown:
			power += delta * 75
		if Input.is_action_just_released("ui_accept") and !hasThrown:
			hasThrown = true
			
	powerBar.set_value(power)

func _physics_process(delta: float) -> void:
	if hasThrown:
		position.y -= (power / 7)
