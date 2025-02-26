extends Control

var roundNum = 1
var throwDir = "vert"


var vertCharge : float = 0
var horCharge : float = 0

var safeRanges = [35, 65, 0, 40, 60, 0, 45, 55, 0]

@onready var vertBar: ProgressBar = $vertBar
@onready var horBar: ProgressBar = $horBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if throwDir == "vert":
		vertBar.set_visible(true)
		vertCharge += pow(.45 + delta, 2)
		vertBar.value = vertCharge
		if Input.is_action_pressed("ui_accept"):
			if vertCharge > safeRanges[roundNum - 1] and vertCharge < safeRanges[roundNum]:
				#roundNum += 2
				throwDir = "hor"
				vertBar.set_visible(false)
				vertCharge = 0
			else:
				print("failed")
	
	if throwDir == "hor":
		horBar.set_visible(true)
		horCharge += pow(.45 + delta, 2)
		horBar.value = horCharge
		if Input.is_action_pressed("ui_accept"):
			if horCharge > safeRanges[roundNum - 1] and horCharge < safeRanges[roundNum]:
				roundNum += 4
				throwDir = "vert"
				horBar.set_visible(false)
				horCharge = 0
			else:
				print("failed")
	
func roundSetup(throwDir, delta: float):
	match throwDir:
		"vert":
			vertBar.set_visible(true)
			vertCharge += pow(.45 + delta, 2)
			vertBar.value = vertCharge
		"hor":
			horBar.set_visible(true)
			horCharge += pow(.45 + delta, 2)
			horBar.value = horCharge
