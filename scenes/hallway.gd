extends Node3D

var position2 : Vector3 = Vector3(5.605, 35.582, 4.491)

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("ufo"):
		position = position2
