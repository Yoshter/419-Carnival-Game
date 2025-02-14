extends Node

#variables to handle in game scores for token-giving
var ufoScore : int = 0
var ufoBeat : bool = false

var dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Custom Funcs
func ufoScoreUp() -> void:
	ufoScore += 1

func ufoScoreReset() -> void:
	ufoScore = 0

func checkBeatGame(gameName) -> bool:
	var beatGame : bool = false
	match gameName:
		"ufo":
			beatGame = ufoBeat
	return beatGame
