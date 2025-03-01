extends Node

var isTalking : bool = false
var isTalkingTo : String
var inUI : bool = false

var needsTeleport = false
var newPosition : Vector3

func setIsTalking(talkBool : bool) -> void:
	isTalking = talkBool

func checkIsTalking() -> bool:
	return isTalking

func setIsTalkingTo(npcName) -> void:
	isTalkingTo = npcName

func checkIsTalkingTo() -> String:
	return isTalkingTo
