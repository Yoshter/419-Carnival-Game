extends Node

#variables to handle in game scores for token-giving
var ufoScore : int = 0
var ufoBeat : bool = false
var ufoChecked : bool = false
var ufoPlugged : bool = false

var speedPitchBeat : bool = false
var speedPitchChecked : bool = false

var dead : bool = false

#Custom Funcs
func ufoScoreUp() -> void:
	ufoScore += 1
	#$ScoreupSound.play() not working

func ufoScoreReset() -> void:
	ufoScore = 0

func setUfoPlugged(isPlugged : bool) -> void:
	ufoPlugged = isPlugged

func checkBeatGame(gameName) -> bool:
	var beatGame : bool = false
	match gameName:
		"ufo":
			beatGame = ufoBeat
		"speedPitch":
			beatGame = speedPitchBeat
	return beatGame
