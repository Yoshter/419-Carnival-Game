extends Node3D

var position2 : Vector3 = Vector3(-18.409, 1.435, -60.0331)

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("ufo"):
		position = position2
