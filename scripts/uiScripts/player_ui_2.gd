extends Control

#Pause Menu Variables ******************************************************************************
@onready var pauseMenu: Control = $pauseMenu
@onready var controls: Control = $pauseMenu/controls
var pauseIsVisible : bool = false
var pauseDelay : float = 0.0

#Settings Menu Variables ***************************************************************************
@onready var settingsMenu: Control = $pauseMenu/settingsMenu

#Confirm Quit Menu Variables ***********************************************************************
@onready var confirmQuitMenu: Control = $pauseMenu/confirmQuitMenu
@onready var confirmQuitSprite: AnimatedSprite2D = $pauseMenu/confirmQuitMenu/fakeDialogueMenu/npcSprite
@onready var fakeDialogAnim: AnimationPlayer = $pauseMenu/confirmQuitMenu/fakeDialogueMenu/fakeDialogAnim
@onready var fakeDialogDelay: Timer = $pauseMenu/confirmQuitMenu/fakeDialogueMenu/fakeDialogDelay
@onready var fakeDialogMenu: Control = $pauseMenu/confirmQuitMenu/fakeDialogueMenu

#Personal Menu Variables ***************************************************************************
@onready var personalMenu: Control = $personalMenu
var personalIsVisible : bool = false

#Inventory Menu Variables **************************************************************************
@onready var inventoryMenu: Control = $personalMenu/inventoryMenu

@onready var ufoTokenIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tokens/ufoToken
@onready var rangeTokenIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tokens/rangeToken
@onready var skeebleTokenIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tokens/skeebleToken
@onready var speedPitchTokenIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tokens/speedPitchToken
@onready var towerTokenIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tokens/towerToken

@onready var ufoTicketIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tickets/ufoTicket
@onready var rangeTicketIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tickets/rangeTicket
@onready var skeebleTicketIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tickets/skeebleTicket
@onready var speedPitchTicketIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tickets/speedPitchTicket
@onready var towerTicketIcon: Sprite2D = $personalMenu/inventoryMenu/itemIcons/tickets/towerTicket

@onready var funPassJrIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/funPassJr
@onready var funPassSrIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/funPassSr
@onready var sawIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/saw
@onready var bbgunIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/bbgun
@onready var joystickIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/joystick
@onready var janitorsKeyIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/janitorsKey
@onready var mainDoorKeyIcon : Sprite2D = $personalMenu/inventoryMenu/itemIcons/items/mainDoorKey

@onready var map: Sprite2D = $personalMenu/mapMenu/Map

#Inspect Menu Variables ****************************************************************************
@onready var itemInspectMenu: Control = $personalMenu/inventoryMenu/itemInspectPage
@onready var itemInfoText: Label = $personalMenu/inventoryMenu/itemInspectPage/itemInfoText
@onready var itemNameText: Label = $personalMenu/inventoryMenu/itemInspectPage/itemNameText

@onready var ufoTokenInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tokens/ufoToken
@onready var speedPitchTokenInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tokens/speedPitchToken
@onready var rangeTokenInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tokens/rangeToken
@onready var skeebleTokenInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tokens/skeebleToken
@onready var towerTokenInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tokens/towerToken

@onready var ufoTicketInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tickets/ufoTicket
@onready var speedPitchTicketInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tickets/speedPitchTicket
@onready var rangeTicketInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tickets/rangeTicket
@onready var towerTicketInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tickets/towerTicket
@onready var skeebleTicketInspect: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/tickets/skeebleTicket

@onready var funPassJrInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/items/funPassJr
@onready var funPassSrInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/items/funPassSr
@onready var sawInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/items/saw
@onready var bbgunInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/weapons/bbgun
@onready var joystickInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/items/joystick
@onready var janitorsKeyInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/items/janitorsKey
@onready var mainDoorKeyInspec: Sprite2D = $personalMenu/inventoryMenu/itemInspectPage/itemSprite/items/mainDoorKey


#Junk / Collectibles Menu Variables ****************************************************************
@onready var junkMenu: Control = $personalMenu/junkMenu

#Objective Menu Variables **************************************************************************
@onready var objectiveMenu: Control = $personalMenu/objectiveMenu
@onready var objectiveText: Label = $personalMenu/objectiveMenu/objectiveText

#Map Menu Variables ********************************************************************************
@onready var mapMenu: Control = $personalMenu/mapMenu

#Interact Menu Variables ***************************************************************************
@onready var interactMenu: Control = $interactMenu

#In Hand HUD Variables **************************************************************************
@onready var inHandSprite: AnimatedSprite2D = $inHandHUD/inHandSprite
@onready var crosshair: Control = $inHandHUD/crosshair
@onready var weaponDelay: Timer = $inHandHUD/weaponDelay
@onready var bbgunShootSound: AudioStreamPlayer = $inHandHUD/bbgunShootSound

#Shooting Range Menu Variables **************************************************************************
@onready var shootingRangeMenu: Control = $shootingRangeMenu
@onready var timerNumText: Label = $shootingRangeMenu/timerNumText
@onready var scoreNumText: Label = $shootingRangeMenu/scoreNumText

#Dialogue Menu Variables
@onready var dialogMenu: Control = $dialogMenu
@onready var npcDialogLabel: Label = $dialogMenu/npcTextLabel
@onready var npcNameLabel: Label = $dialogMenu/npcNameLabel
@onready var npcSpriteAnim: AnimatedSprite2D = $dialogMenu/npcSprite
@onready var textAnim: AnimationPlayer = $dialogMenu/textAnim
var dialogCount : int = 0
var maxDialogCount : int = 0

#Get Item Menu Variables
@onready var getItemMenu: Control = $getItemMenu

#Sound Effect Variables **************************************************************************
@onready var closesfx: AudioStreamPlayer = $sfx/closeSFX
@onready var opensfx: AudioStreamPlayer = $sfx/openSFX
@onready var switchsfx: AudioStreamPlayer = $sfx/switchSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(PlayerGlobal.getCanInteract())
	#HANDLE INTERACT MENU
	if PlayerGlobal.getCanInteract():
		interactMenu.set_visible(true)
	else:
		interactMenu.set_visible(false)
	
	#HANDLE PAUSE MENU
	pauseDelay += delta
	if Input.is_action_just_pressed("Pause") and pauseIsVisible and pauseDelay > 0.1 and !PlayerGlobal.isDeaf:
		unpause()
	if Input.is_action_just_pressed("Pause") and !pauseIsVisible and !personalIsVisible and pauseDelay > 0.1 and !PlayerGlobal.isTalking: #!PlayerGlobal.isDeaf and !PlayerGlobal.inUI and 
		pause()
	
	#HANDLE PERSONAL MENU
	if Input.is_action_just_pressed("tab") and personalIsVisible and pauseDelay > 0.1 and !PlayerGlobal.isDeaf:
		closePersonal()
	if Input.is_action_just_pressed("tab") and !personalIsVisible and !pauseIsVisible and pauseDelay > 0.1 and !PlayerGlobal.isTalking:
		openPersonal()
	
	#HANDLE SHOOTING RANGE
	if PlayerGlobal.inShootingRange:
		shootingRangeMenu.set_visible(true)
		scoreNumText.set_text(str(GamesGlobal.shootingRangeScore))
		timerNumText.set_text(str(round(GamesGlobal.shootingRangeTimeLeft,)))
	else:
		shootingRangeMenu.set_visible(false)
	
	#HANDLE WEAPON UI
	match WeaponsGlobal.getCurrentWeapon():
		"fists":
			inHandSprite.play("fistIdle")
			weaponDelay.wait_time = 0.8
		"pipe":
			inHandSprite.play("pipeIdle")
			weaponDelay.wait_time = 1.2
		"bbgun":
			inHandSprite.play("bbgunIdle")
			weaponDelay.wait_time = 0.8
	
	#HANDLE DIALOGUE MENU
	if PlayerGlobal.isTalking:
		dialogMenu.set_visible(true)
		PlayerGlobal.setCanInteract(false)
		npcNameLabel.set_text(PlayerGlobal.checkIsTalkingTo())
		match PlayerGlobal.checkIsTalkingTo():
			"CARN-E":
				npcSpriteAnim.play("carneTalking")
		if !textAnim.is_playing():
				textAnim.play("moveOver")
		if !(dialogCount > maxDialogCount):
			dialogMenu.set_visible(true)
			maxDialogCount = DialogueGlobal.returnMaxDialogueCount(PlayerGlobal.checkIsTalkingTo())
			npcDialogLabel.set_text(str(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), dialogCount)))
		else:
			#print("dialogue count : " + str(dialogueCount))
			dialogMenu.set_visible(false)
			if DialogueGlobal.returnGivingItem(PlayerGlobal.checkIsTalkingTo()):
				ItemsGlobal.giveItem(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), -2))
				PlayerGlobal.setIsTalking(false)
				dialogCount = 0
				PlayerGlobal.inUI = true
			else:
				getItemMenu.set_visible(false)
				ItemsGlobal.showItemUI = false
				PlayerGlobal.setIsTalking(false)
				PlayerGlobal.inUI = false
				dialogCount = 0

#PERSONAL MENU BUTTON FUNCTIONS **************************************************************************

func openPersonal() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	personalMenu.set_visible(true)
	PlayerGlobal.inUI = true
	PlayerGlobal.isPaused = true
	pauseDelay = 0.0
	bbgunShootSound.volume_db = -80.0
	personalIsVisible = true
	opensfx.play(0.0)

func closePersonal() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	personalMenu.set_visible(false)
	inventoryMenu.set_visible(false)
	objectiveMenu.set_visible(false)
	mapMenu.set_visible(false)
	PlayerGlobal.inUI = false
	PlayerGlobal.isPaused = false
	pauseDelay = 0.0
	bbgunShootSound.volume_db = 0.0
	personalIsVisible = false
	closesfx.play(0.0)

#MAP MENU BUTTONS **************************************************************************
func _on_map_button_pressed() -> void:
	mapMenu.set_visible(true)

func _on_quit_map_menu_pressed() -> void:
	mapMenu.set_visible(false)

#INVENTORY MENU FUNCTIONS **************************************************************************
func _on_inventory_button_pressed() -> void:
	updateItemIcons()
	inventoryMenu.set_visible(true)

func _on_quit_inv_button_pressed() -> void:
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
	if ItemsGlobal.checkItem("janitorsKey"):
		janitorsKeyIcon.set_visible(true)
	if ItemsGlobal.checkItem("mainDoorKey"):
		mainDoorKeyIcon.set_visible(true)

func inspectItem(itemName : String, itemInfo) -> void:
	uninspectAllItems()
	itemNameText.set_text(itemName)
	itemInfoText.set_text(itemInfo)
	match itemName:
		"UFO Blast! Token":
			ufoTokenInspec.set_visible(true)
		"UFO Blast! Ticket":
			ufoTicketInspec.set_visible(true)
		"Junior Fun Pass":
			funPassJrInspec.set_visible(true)
		"BB Gun":
			bbgunInspec.set_visible(true)
		_:
			pass
	objectiveMenu.set_visible(false)
	junkMenu.set_visible(false)
	itemInspectMenu.set_visible(true)

func uninspectAllItems() -> void:
	print("uninspecting")
	ufoTokenInspec.set_visible(false)
	speedPitchTokenInspec.set_visible(false)
	
	ufoTicketInspec.set_visible(false)
	speedPitchTicketInspec.set_visible(false)
	
	funPassJrInspec.set_visible(false)
	
	bbgunInspec.set_visible(false)

func _on_quit_item_inspect_pressed() -> void:
	uninspectAllItems()
	itemInspectMenu.set_visible(false)

func _on_ufo_token_button_pressed() -> void:
	inspectItem("UFO Blast! Token", "A coin used to play the 'UFO Blast!' \n game in the Digital Arcade. \n Given to you by your... friend? \n the CARN-E.")

func _on_ufo_ticket_button_pressed() -> void:
	inspectItem("UFO Blast! Ticket", "A ticket earned by beating the game \n UFO Blast! \n\n Don't feel THAT proud")

func _on_fun_pass_jr_button_pressed() -> void:
	inspectItem("Junior Fun Pass", "Opens a certain 'fun' gate. \n Great times await! Maybe!")

func _on_fun_pass_sr_butt_pressed():
	inspectItem("Senior Fun Pass", "Opens an even FUNNER 'fun' gate. \n Even greater times await! Definitely!!")

func _on_bbgun_button_pressed() -> void:
	inspectItem("BB Gun", "A reasonably harmless BB gun. \n Could still be useful though...")

#OBJECTIVE MENU FUNCTIONS **************************************************************************
func _on_objective_button_pressed() -> void:
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
			objectiveText.set_text("If you're BOARD, go to the arcade.")
		7: #keep looking for them tokens.
			objectiveText.set_text("Find the rest of the tokens.")
		9: #all tickets collected.
			objectiveText.set_text("Congratulations on finding all the tickets! Go talk to the carnie to recieve your prize.")
		10:
			objectiveText.set_text("Go fix the power!")
		11:
			objectiveText.set_text("You fixed the power, get outta there!!!")
		12:
			objectiveText.set_text(str(DialogueGlobal.objEncCount) + ", " + str(DialogueGlobal.danEncCount))
	print("IN MENU: " + str(DialogueGlobal.objEncCount))
	objectiveMenu.set_visible(true)

func _on_quit_obj_menu_pressed() -> void:
	objectiveMenu.set_visible(false)

#PAUSE MENU BUTTON FUNCTIONS ********************************
func pause() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pauseMenu.set_visible(true)
	controls.set_visible(true)
	PlayerGlobal.isPaused = true
	PlayerGlobal.inUI = true
	pauseIsVisible = true
	pauseDelay = 0.0
	bbgunShootSound.volume_db = -80.0

func unpause() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pauseMenu.set_visible(false)
	confirmQuitMenu.set_visible(false)
	if PlayerGlobal.controlsShown:
		controls.set_visible(false)
	PlayerGlobal.isPaused = false
	PlayerGlobal.inUI = false
	pauseIsVisible = false
	pauseDelay = 0.0
	bbgunShootSound.volume_db = 0.0

func _on_settings_pressed() -> void:
	settingsMenu.set_visible(true)

func _on_quit_settings_button_pressed() -> void:
	settingsMenu.set_visible(false)

func _on_bug_report_pressed() -> void:
	#$OpenSFX.play()
	OS.shell_open("https://forms.gle/rjMwnETHGZXH6RL9A")

func _on_quit_game_pressed() -> void:
	confirmQuitMenu.set_visible(true)
	fakeDialogDelay.start()

#CONFIRM QUIT MENU BUTTON FUNCTIONS ********************************
func _on_confirm_quit_pressed() -> void:
	get_tree().quit()

func _on_leave_quit_pressed() -> void:
	confirmQuitMenu.set_visible(false)
	fakeDialogDelay.stop()

func _on_fake_dialog_delay_timeout() -> void:
	fakeDialogMenu.set_visible(true)
	fakeDialogAnim.play("moveOver")
	confirmQuitSprite.play("carneTalking")
