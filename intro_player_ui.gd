extends Control

@onready var pauseMenu: Control = $PauseMenu
@onready var inventoryMenu: Control = $PauseMenu/inventoryMenu
@onready var objectiveMenu: Control = $PauseMenu/objectiveMenu
@onready var settingsMenu: Control = $PauseMenu/settingsMenu
@onready var mapMenu: Control = $PauseMenu/mapMenu
@onready var confirm_quit_2: Control = $PauseMenu/ConfirmQuit2
@onready var pauseCloseSFX: AudioStreamPlayer = $pauseClose
@onready var controls: Control = $controls
@onready var tabSwitchSfx = $"TabSwitch SFX"
@onready var openSfx = $OpenSFX

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
		openSfx.play(0.0)

func _on_quit_2_pressed() -> void:
	confirm_quit_2.set_visible(true)
	tabSwitchSfx.play(0.0)

func _on_map_pressed() -> void:
	mapMenu.set_visible(true)
	tabSwitchSfx.play(0.0)

func _on_bug_report_pressed() -> void:
	OS.shell_open("https://forms.gle/rjMwnETHGZXH6RL9A")

func _on_inventory_pressed() -> void:
	inventoryMenu.set_visible(true)
	tabSwitchSfx.play(0.0)

func _on_objective_pressed() -> void:
	objectiveMenu.set_visible(true)
	tabSwitchSfx.play(0.0)

func _on_settings_pressed() -> void:
	settingsMenu.set_visible(true)
	tabSwitchSfx.play(0.0)

func _on_quit_inv_pressed() -> void:
	inventoryMenu.set_visible(false)
	tabSwitchSfx.play(0.0)

func _on_quit_obj_pressed() -> void:
	objectiveMenu.set_visible(false)
	tabSwitchSfx.play(0.0)

func _on_quit_settings_pressed() -> void:
	settingsMenu.set_visible(false)
	tabSwitchSfx.play(0.0)

func _on_quit_inv_2_pressed() -> void:
	mapMenu.set_visible(false)
	tabSwitchSfx.play(0.0)

func _on_no_pressed() -> void:
	confirm_quit_2.set_visible(false)
	tabSwitchSfx.play(0.0)

func _on_yes_pressed() -> void:
	get_tree().quit()
