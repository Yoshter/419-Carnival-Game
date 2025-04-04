extends Node

#UPDATE VAR used if items need to be updated in UI / recieved
var needsItemUpdate : bool = false
var showItemUI : bool = false

#don't want to write 'has' a million times so if false, you do NOT have the item
var ufoTokenBool : bool = false
var ufoTicketBool : bool = false
var speedPitchTokenBool : bool = false
var speedPitchTicketBool : bool = false
var skeebleTokenBool : bool = false
var skeebleTicketBool : bool = false
var towerTokenBool : bool = false
var towerTicketBool : bool = false
var rangeTokenBool : bool = false
var rangeTicketBool : bool = false

var funPassLevel2 : bool = false
var funPassLevel3 : bool = true
var saw : bool = false
var bbgun : bool = false

var map : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if itemUpdateReq():
		updateItems()

#Custom Functions
func updateItems() -> void:
	if !ufoTicketBool and GamesGlobal.checkBeatGame("ufo"):
		giveItem("ufoTicket")
	if !speedPitchTicketBool and GamesGlobal.checkBeatGame("speedPitch"):
		giveItem("speedPitchTicket")
	if !towerTicketBool and GamesGlobal.checkBeatGame("tower"):
		giveItem("towerToken")

func giveItem(itemName) -> void:
	if !checkItem(itemName):
		match itemName:
			"ufoToken":
				ufoTokenBool = true
			"ufoTicket":
				ufoTicketBool = true
			"speedPitchToken":
				speedPitchTokenBool = true
			"speedPitchTicket":
				speedPitchTicketBool = true
			"skeebleToken":
				skeebleTokenBool = true
			"skeebleTicket":
				skeebleTicketBool = true
			"towerToken":
				towerTokenBool = true
			"towerTicket":
				towerTicketBool = true
			"rangeToken":
				rangeTokenBool = true
			"rangeTicket":
				rangeTicketBool = true
			"funPassLevel2":
				funPassLevel2 = true
			"funPassLevel3":
				funPassLevel3 = true
			"saw":
				saw = true
			"bbgun":
				bbgun = true
			"map":
				map = true
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
		"skeebleToken":
			hasItem = skeebleTokenBool
		"skeebleTicket":
			hasItem = skeebleTicketBool
		"towerToken":
			hasItem = towerTokenBool
		"towerTicket":
			hasItem = towerTicketBool
		"rangeToken":
			hasItem = rangeTokenBool
		"rangeTicket":
			hasItem = rangeTicketBool
		"funPassLevel2":
			hasItem = funPassLevel2
		"funPassLevel3":
			hasItem = funPassLevel3
		"saw":
			hasItem = saw
		"bbgun":
			hasItem = bbgun
		"map":
			hasItem = map
		_:
			hasItem = false
	return hasItem

func itemUpdateSet(needsUpdate) -> void:
	needsItemUpdate = needsUpdate

func itemUpdateReq() -> bool:
	return needsItemUpdate
