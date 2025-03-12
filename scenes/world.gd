extends Node3D

var position1 : Vector3 = Vector3(-101.1,1.207,-154.32)
var position2 : Vector3 = Vector3(-18.409, 1.435, -60.0331)

func _ready() -> void:
	if !GamesGlobal.checkBeatGame("ufo"):
		position = position1

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("ufo"):
		position = position2	
