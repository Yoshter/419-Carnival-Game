extends Control

@onready var confirm_quit_2: Control = $PauseMenu/ConfirmQuit2
@onready var label : Label = $DialogueMenu/Label
@onready var dialogueTimer: Timer = $dialogueTimer

#Control Pop-Up
@onready var controls: Control = $controls
var controlsShown : bool = false

#menus
@onready var pauseMenu : Control = $PauseMenu
@onready var getItemMenu : Control = $GetItemMenu
@onready var dialogueMenu : Control = $DialogueMenu
@onready var inventoryMenu: Control = $PauseMenu/inventoryMenu
@onready var mapMenu: Control = $PauseMenu/mapMenu
@onready var interactMenu: Control = $interactMenu
@onready var shootingRangeMenu: Control = $shootingRangeMenu

@onready var rangeScoreText: Label = $shootingRangeMenu/scoreText
@onready var crosshair: Control = $crosshair
@onready var gun_ui: Sprite2D = $Gun_UI

#item icons
@onready var ufoTokenIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tokens/ufoToken
@onready var rangeTokenIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tokens/rangeToken
@onready var skeebleTokenIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tokens/skeebleToken
@onready var speedPitchTokenIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tokens/speedPitchToken
@onready var towerTokenIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tokens/towerToken

@onready var ufoTicketIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tickets/ufoTicket
@onready var rangeTicketIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tickets/rangeTicket
@onready var skeebleTicketIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tickets/skeebleTicket
@onready var speedPitchTicketIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tickets/speedPitchTicket
@onready var towerTicketIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/tickets/towerTicket

@onready var funPassJrIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/funPassJr
@onready var funPassSrIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/funPassSr
@onready var sawIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/saw
@onready var bbgunIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/bbgun
@onready var joystickIcon: Sprite2D = $PauseMenu/inventoryMenu/itemIcons/joystick

@onready var map: Sprite2D = $PauseMenu/mapMenu/Map

var dialogueCount : int = 0
var maxDialogueCount : int = 0
var isVisible : bool = false
var delay : float = 0.0
var hasGun : bool = false

@onready var objectiveMenu: Control = $PauseMenu/objectiveMenu
@onready var objectiveText: Label = $PauseMenu/objectiveMenu/objectiveText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delay += delta
	
	if PlayerGlobal.getCanInteract():
		interactMenu.set_visible(true)
	else:
		interactMenu.set_visible(false)
	
	if !hasGun and ItemsGlobal.checkItem("bbgun"):
		hasGun = true
		crosshair.set_visible(true)
		gun_ui.set_visible(true)
	
	#if PlayerGlobal.controlsShown:
		#controls.set_visible(false)
	
	if PlayerGlobal.inShootingRange:
		rangeScoreText.set_text(str(GamesGlobal.shootingRangeScore))
		shootingRangeMenu.set_visible(true)
	else:
		shootingRangeMenu.set_visible(false)
	
	if Input.is_action_just_pressed("Pause") and !isVisible and delay > 0.1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		pauseMenu.set_visible(true)
		controls.set_visible(true)
		PlayerGlobal.inUI = true
		isVisible = true
		delay = 0.0
		$OpenSFX.play()
	if Input.is_action_just_pressed("Pause") and isVisible and delay > 0.1:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pauseMenu.set_visible(false)
		if PlayerGlobal.controlsShown:
			controls.set_visible(false)
		inventoryMenu.set_visible(false)
		objectiveMenu.set_visible(false)
		mapMenu.set_visible(false)
		PlayerGlobal.inUI = false
		isVisible = false
		delay = 0.0
		$"Close SFX".play()
		
	#print(ItemsGlobal.showItemUI)
	#print(PlayerGlobal.inUI)
	
	if PlayerGlobal.isTalking:
		PlayerGlobal.setCanInteract(false)
		if !(dialogueCount > maxDialogueCount):
			dialogueMenu.set_visible(true)
			maxDialogueCount = DialogueGlobal.returnMaxDialogueCount(PlayerGlobal.checkIsTalkingTo())
			label.set_text(str(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), dialogueCount)))
			if dialogueTimer.is_stopped():
				dialogueTimer.start()
		else:
			dialogueCount = 0
			dialogueMenu.set_visible(false)
			if DialogueGlobal.returnGivingItem(PlayerGlobal.checkIsTalkingTo()):
				ItemsGlobal.giveItem(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), -2))
				PlayerGlobal.setIsTalking(false)
				PlayerGlobal.inUI = true
			else:
				getItemMenu.set_visible(false)
				ItemsGlobal.showItemUI = false
				PlayerGlobal.setIsTalking(false)
				PlayerGlobal.inUI = false
			#DialogueGlobal.addToEncCount(PlayerGlobal.checkIsTalkingTo())
	
	if PlayerGlobal.inUI and Input.is_action_pressed("interact"):
		PlayerGlobal.inUI = false
		getItemMenu.set_visible(false)
		ItemsGlobal.showItemUI = false
	#print(ItemsGlobal.showItemUI)
	if ItemsGlobal.showItemUI:
		getItemMenu.set_visible(true)
		PlayerGlobal.inUI = true
	else:
		getItemMenu.set_visible(false)
		PlayerGlobal.inUI = false

func _on_dialogue_timer_timeout() -> void:
	dialogueCount += 1
	
func _on_quit_2_pressed() -> void:
	$OpenSFX.play()
	confirm_quit_2.set_visible(true)

func _on_inventory_pressed() -> void:
	updateItemIcons()
	$"TabSwitch SFX".play()
	inventoryMenu.set_visible(true)

func _on_quit_inv_pressed() -> void:
	inventoryMenu.set_visible(false)

func updateItemIcons() -> void:
	if ItemsGlobal.checkItem("ufoToken"):
		ufoTokenIcon.set_visible(true)
	if ItemsGlobal.checkItem("ufoTicket"):
		ufoTicketIcon.set_visible(true)
	if ItemsGlobal.checkItem("speedPitchToken"):
		speedPitchTokenIcon.set_visible(true)
	if ItemsGlobal.checkItem("speedPitchTicket"):
		speedPitchTicketIcon.set_visible(true)
	if ItemsGlobal.checkItem("skeebleToken"):
		skeebleTokenIcon.set_visible(true)
	if ItemsGlobal.checkItem("skeebleTicket"):
		skeebleTicketIcon.set_visible(true)
	if ItemsGlobal.checkItem("towerToken"):
		towerTokenIcon.set_visible(true)
	if ItemsGlobal.checkItem("towerTicket"):
		towerTicketIcon.set_visible(true)
	if ItemsGlobal.checkItem("rangeToken"):
		rangeTokenIcon.set_visible(true)
	if ItemsGlobal.checkItem("rangeTicket"):
		rangeTicketIcon.set_visible(true)
	if ItemsGlobal.checkItem("funPassLevel2"):
		funPassJrIcon.set_visible(true)
	if ItemsGlobal.checkItem("funPassLevel3"):
		funPassSrIcon.set_visible(true)
	if ItemsGlobal.checkItem("saw"):
		sawIcon.set_visible(true)
	if ItemsGlobal.checkItem("bbgun"):
		bbgunIcon.set_visible(true)
	if ItemsGlobal.checkItem("joystick"):
		joystickIcon.set_visible(true)

func _on_no_pressed() -> void:
	confirm_quit_2.set_visible(false)

func _on_yes_pressed() -> void:
	get_tree().quit()

func _on_map_pressed() -> void:
	mapMenu.set_visible(true)
	if ItemsGlobal.checkItem("map"):
		map.set_visible(true)
	$"TabSwitch SFX".play()

func _on_hud_timer_timeout() -> void:
	PlayerGlobal.controlsShown = true
	controls.set_visible(false)

func _on_resume_pressed() -> void:
	$OpenSFX.play()
	if isVisible and delay > 0.1:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pauseMenu.set_visible(false)
		#pauseMenu.set_visible(false)
		#inventoryMenu.set_visible(false)
		#mapMenu.set_visible(false)
		#PlayerGlobal.inUI = false
		#isVisible = false
		#delay = 0.0
		#$"Close SFX".play()
		pass
	else:
		pass
	

func _on_quit_inv_2_pressed() -> void:
	mapMenu.set_visible(false)

func _on_objective_pressed() -> void:
	$OpenSFX.play()
	match DialogueGlobal.objEncCount:
		0: #until you walk in
			objectiveText.set_text("Find somewhere to rest.")
		1: #until talk to carnie
			objectiveText.set_text("Who's that weird guy by the entrance?")
		2: #until you beat ufo
			objectiveText.set_text("Apparently there's something in the arcade.")
		3: #until you talk to carnie
			objectiveText.set_text("You just got a ticket. Go ask the carnie what it's for.")
		4: #until you beat speed pitch
			objectiveText.set_text("Take yourself out to the ball game!")
		5: #until you talk to carnie
			objectiveText.set_text("Go see what the carnie's got to say about THIS ticket.")
		6: #find use for saw
			objectiveText.set_text("If you're really BOARED go to the arcade lol.")
		7: #keep looking for them tokens.
			objectiveText.set_text("Find the rest of the tokens.")
	print("IN MENU: " + str(DialogueGlobal.objEncCount))
	objectiveMenu.set_visible(true)

func _on_quit_obj_pressed() -> void:
	objectiveMenu.set_visible(false)


func _on_bug_report_pressed():
	$OpenSFX.play()
	OS.shell_open("https://forms.gle/rjMwnETHGZXH6RL9A")
