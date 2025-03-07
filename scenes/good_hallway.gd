extends Node3D

var position2 : Vector3 = Vector3(-15.26, -0.673, -26.211)

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("ufo"):
		position = position2
