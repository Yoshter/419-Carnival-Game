extends Node

#UPDATE VAR used if items need to be updated in UI / recieved
var needsItemUpdate : bool = false
var showItemUI : bool = false

#don't want to write 'has' a million times so if false, you do NOT have the item
var ufoTokenBool : bool = true
var ufoTicketBool : bool = false

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
	if GamesGlobal.checkBeatGame("ufo"):
		giveItem("ufoToken")

func giveItem(itemName) -> void:
	match itemName:
		"ufoToken":
			ufoTokenBool = true
		"ufoTicket":
			ufoTicketBool = true
		"speedPitchToken":
			speedPitchTokenBool = true
		"speedPitchTicket":
			speedPitchTicketBool = true
	showItemUI = true

func checkItem(itemName) -> bool:
	var hasItem : bool = false
	match itemName:
		"ufoToken":
			if ufoTokenBool:
				hasItem = true
		"ufoTicket":
			if ufoTicketBool:
				hasItem = true
		"speedPitchToken":
			if speedPitchTokenBool:
				hasItem = true
		"speedPitchTicket":
			if speedPitchTicketBool:
				hasItem = true
	return hasItem

func itemUpdateSet(needsUpdate) -> void:
	needsItemUpdate = needsUpdate

func itemUpdateReq() -> bool:
	return needsItemUpdate
