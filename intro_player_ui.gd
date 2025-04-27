extends Control

@onready var pauseMenu: Control = $PauseMenu
@onready var inventoryMenu: Control = $PauseMenu/inventoryMenu
@onready var objectiveMenu: Control = $PauseMenu/objectiveMenu
@onready var settingsMenu: Control = $PauseMenu/settingsMenu
@onready var mapMenu: Control = $PauseMenu/mapMenu
@onready var confirm_quit_2: Control = $PauseMenu/ConfirmQuit2
@onready var pauseCloseSFX: AudioStreamPlayer = $pauseClose
@onready var controls: Control = $controls

var isVisible : bool = false
var delay : float = 0.1

func _process(delta: float) -> void:
	
	delay += delta
	
	if PlayerGlobal.canMove and Input.is_action_just_pressed("Pause") and isVisible and delay > 0.1 and !PlayerGlobal.isDeaf:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pauseMenu.set_visible(false)
		if PlayerGlobal.controlsShown:
			controls.set_visible(false)
		inventoryMenu.set_visible(false)
		objectiveMenu.set_visible(false)
		confirm_quit_2.set_visible(false)
		mapMenu.set_visible(false)
		#PlayerGlobal.inUI = false
		delay = 0.0
		#bbgunShootSound.volume_db = 0.0
		isVisible = false
		pauseCloseSFX.play(0.0)
			
	if PlayerGlobal.canMove and Input.is_action_just_pressed("Pause") and !isVisible and delay > 0.1 and !PlayerGlobal.isDeaf:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		pauseMenu.set_visible(true)
		controls.set_visible(true)
		#PlayerGlobal.inUI = true
		isVisible = true
		delay = 0.0
		#bbgunShootSound.volume_db = -80.0
		pauseCloseSFX.play(0.0)
