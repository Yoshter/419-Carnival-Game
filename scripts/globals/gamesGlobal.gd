extends Node

#variables to handle in game scores for token-giving
var ufoScore : int = 0
var ufoBeat : bool = false
var ufoChecked : bool = false

var dead : bool = false

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
