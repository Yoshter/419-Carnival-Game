extends Node

var isTalking : bool = false
var isTalkingTo : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setIsTalking(talkBool : bool) -> void:
	isTalking = talkBool

func checkIsTalking() -> bool:
	return isTalking

func setIsTalkingTo(npcName) -> void:
	isTalkingTo = npcName

func checkIsTalkingTo() -> String:
	return isTalkingTo
