extends Node

var isTalking : bool = false
var isTalkingTo : String
var inUI : bool = false
var controlsShown = false

var interactText : String

var needsTeleport = false
var newPosition : Vector3

func setInteractText(newText : String) -> void:
	interactText = newText

func getInteractText() -> String:
	return interactText

func setIsTalking(talkBool : bool) -> void:
	isTalking = talkBool

func checkIsTalking() -> bool:
	return isTalking

func setIsTalkingTo(npcName) -> void:
	isTalkingTo = npcName

func checkIsTalkingTo() -> String:
	return isTalkingTo
