extends Control


@onready var label : Label = $DialogueMenu/Label
@onready var dialogueTimer: Timer = $dialogueTimer

#menus
@onready var pauseMenu : Control = $PauseMenu
@onready var getItemMenu : Control = $GetItemMenu
@onready var dialogueMenu : Control = $DialogueMenu
@onready var inventoryMenu: Control = $PauseMenu/inventoryMenu

#item icons
@onready var funPassIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/funPass

var dialogueCount : int = 0
var maxDialogueCount : int = 0
var isVisible : bool = false
var delay : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delay += delta
	if Input.is_action_just_pressed("Pause") and !isVisible and delay > 0.1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		pauseMenu.set_visible(true)
		isVisible = true
		delay = 0.0
		$OpenSFX.play()
	if Input.is_action_just_pressed("Pause") and isVisible and delay > 0.1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pauseMenu.set_visible(false)
		isVisible = false
		delay = 0.0
		$"Close SFX".play()
		
	#print(ItemsGlobal.showItemUI)
	#print(PlayerGlobal.inUI)
	
	if PlayerGlobal.isTalking:
		if !dialogueCount > maxDialogueCount:
			dialogueMenu.set_visible(true)
			maxDialogueCount = DialogueGlobal.returnMaxDialogueCount(PlayerGlobal.checkIsTalkingTo())
			label.set_text(str(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), dialogueCount)))
			if dialogueTimer.is_stopped():
				dialogueTimer.start()
		else:
			dialogueCount = 0
			dialogueMenu.set_visible(false)
			if DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), -2):
				ItemsGlobal.giveItem(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), -2))
			PlayerGlobal.setIsTalking(false)
			PlayerGlobal.inUI = true
			#DialogueGlobal.addToEncCount(PlayerGlobal.checkIsTalkingTo())
	
	if PlayerGlobal.inUI and Input.is_action_pressed("interact"):
		PlayerGlobal.inUI = false
		getItemMenu.set_visible(false)
		ItemsGlobal.showItemUI = false
	#print(ItemsGlobal.showItemUI)
	if ItemsGlobal.showItemUI:
		getItemMenu.set_visible(true)
		PlayerGlobal.inUI = true

func _on_dialogue_timer_timeout() -> void:
	dialogueCount += 1
	
func _on_quit_2_pressed() -> void:
	get_tree().quit()

func _on_inventory_pressed() -> void:
	updateItemIcons()
	$"TabSwitch SFX".play()
	inventoryMenu.set_visible(true)

func _on_quit_inv_pressed() -> void:
	inventoryMenu.set_visible(false)

func updateItemIcons() -> void:
	if ItemsGlobal.checkItem("funPassLevel2"):
		funPassIcon.set_visible(true)
