extends Node3D

@onready var janitorDoorwayBox: CSGBox3D = $ground/mainarea/mainTentCyl/janitorDoorway
var janitorDoorwayVisible : bool = false


func _process(delta: float) -> void:
	if !janitorDoorwayVisible and GamesGlobal.checkBeatGame("ufo"):
		janitorDoorwayBox.set_visible(true)
		janitorDoorwayVisible = true
