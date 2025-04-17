extends Node3D

var position1 : Vector3 = Vector3(-99.57,1.243,-154.32)
var position2 : Vector3 = Vector3(-18.409, 1.435, -60.0331)
@onready var lights: Node3D = $lights
@onready var towerMusic: AudioStreamPlayer3D = $Towermusic
@onready var buzzing: AudioStreamPlayer3D = $OmniLight3D/Buzzing

func _ready() -> void:
	if PlayerGlobal.isBlackout:
		towerMusic.stop()
		buzzing.stop()
	if !PlayerGlobal.isBlackout:
		if !towerMusic.is_playing():
			towerMusic.start(0.0)
		if !buzzing.is_playing():
			buzzing.start(0.0)
	if !GamesGlobal.checkBeatGame("ufo"):
		position = position1

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("ufo"):
		position = position2
	if PlayerGlobal.isBlackout:
		lights.set_visible(false)
	else:
		lights.set_visible(true)
