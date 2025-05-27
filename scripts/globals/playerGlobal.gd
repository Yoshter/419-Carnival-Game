extends Node

var performanceModeOn = false

var isTalking : bool = false
var isTalkingTo : String
var isPaused : bool = false
var inUI : bool = true
var controlsShown = false

var mustFloat = false
var canMove : bool = false
var canInteract : bool = false
var interactText : String

var needsTeleport = false
var newPosition : Vector3
var newRotation : float = 0.0
var inShootingRange : bool = false
var isEndingSequence : bool = false
var isBlackout : bool = false
var afterBlackout : bool = false

var isDeaf : bool = false

var beatCARN : bool = false

var gameTime : float = 0.0

func setInteractText(newText : String) -> void:
	interactText = newText

func getInteractText() -> String:
	return interactText

func setCanInteract(canInteractBool : bool) -> void:
	canInteract = canInteractBool

func getCanInteract() -> bool:
	return canInteract

func setIsTalking(talkBool : bool) -> void:
	isTalking = talkBool

func checkIsTalking() -> bool:
	return isTalking

func setIsTalkingTo(npcName) -> void:
	isTalkingTo = npcName

func checkIsTalkingTo() -> String:
	return isTalkingTo

func resetPlayerGlobal() -> void:
	isTalking = false
	isTalkingTo = ""
	inUI = true
	controlsShown = false
	mustFloat = false
	canMove = false
	canInteract = false
	interactText = ""
	needsTeleport = false
	newPosition = Vector3(0,0,0)
	newRotation = 0.0
	inShootingRange  = false
	isEndingSequence = false
	isBlackout = false
	afterBlackout = false
	isDeaf = false
	beatCARN = false
	gameTime = 0.0
