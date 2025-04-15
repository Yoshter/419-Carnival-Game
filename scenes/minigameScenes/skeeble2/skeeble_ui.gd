extends Control

var throwPower : float = 0.0
@onready var throwPowerBar: ProgressBar = $throwPowerBar
var isAdding : bool = true

func _process(delta: float) -> void:
	if isAdding:
		throwPower += delta * 30
	if Input.is_action_just_pressed("ui_accept"):
		if throwPower >= 5 and throwPower <= 20:
			print("GOOMAH")
		elif throwPower >= 30 and throwPower <= 45:
			print("TANKO")
		elif throwPower > 45 and throwPower < 55:
			print("SHLUCK")
		elif throwPower >= 55 and throwPower <= 70:
			print("BUPKIS")
		elif throwPower >= 80 and throwPower <= 95:
			print("HEYOO")
		else:
			pass
	if throwPower == 100:
		#missanim plays
		pass
	throwPowerBar.set_value(throwPower)
