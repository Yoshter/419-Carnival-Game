extends Control
@onready var pauseMenu: Control = $PauseMenu
@onready var getItemMenu: Control = $GetItemMenu
var isVisible : bool = false
var delay : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delay += delta
	if Input.is_action_just_pressed("Pause") and !isVisible and delay > 0.1:
		pauseMenu.set_visible(true)
		isVisible = true
		delay = 0.0
	if Input.is_action_just_pressed("Pause") and isVisible and delay > 0.1:
		pauseMenu.set_visible(false)
		isVisible = false
		delay = 0.0
	
	if ItemsGlobal.showItemUI:
		getItemMenu.set_visible(true)
