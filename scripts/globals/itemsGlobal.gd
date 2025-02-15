extends Node

#UPDATE VAR used if items need to be updated in UI / recieved
var needsItemUpdate : bool = false
var showItemUI : bool = false

#don't want to write 'has' a million times so if false, you do NOT have the item
var ufoTokenBool : bool = false
var ufoTicketBool : bool = false

var funPassLevel2 : bool = false

var speedPitchTokenBool : bool = false
var speedPitchTicketBool : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if itemUpdateReq():
		updateItems()

#Custom Functions
func updateItems() -> void:
	var itemString = "ufoTicket"
	print(ufoTicketBool)
	print(GamesGlobal.checkBeatGame("ufo"))
	if !ufoTicketBool and GamesGlobal.checkBeatGame("ufo"):
			giveItem(itemString)

func giveItem(itemName) -> void:
	if !checkItem(itemName):
		match itemName:
			"ufoToken":
				ufoTokenBool = true
			"ufoTicket":
				ufoTicketBool = true
			"funPass2":
				funPassLevel2 = true
			"speedPitchToken":
				speedPitchTokenBool = true
			"speedPitchTicket":
				speedPitchTicketBool = true
		showItemUI = true

func checkItem(itemName) -> bool:
	var hasItem : bool = false
	match itemName:
		"ufoToken":
			hasItem = ufoTokenBool
		"ufoTicket":
			hasItem = ufoTicketBool
		"speedPitchToken":
			hasItem = speedPitchTokenBool
		"speedPitchTicket":
			hasItem = speedPitchTicketBool
		_:
			hasItem = false
	return hasItem

func itemUpdateSet(needsUpdate) -> void:
	needsItemUpdate = needsUpdate

func itemUpdateReq() -> bool:
	return needsItemUpdate
