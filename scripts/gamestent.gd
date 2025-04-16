extends Node3D

@onready var janitorDoorwayBox: CSGBox3D = $ground/mainarea/mainTentCyl/janitorDoorway
var janitorDoorwayVisible : bool = false
@onready var carnivalMusic: AudioStreamPlayer3D = $"audioSpeakers/Carnival music"
var musicTime : float 
@onready var mainLight: OmniLight3D = $Lights/OmniLight3D4

func _process(delta: float) -> void:
	if !janitorDoorwayVisible and GamesGlobal.checkBeatGame("ufo"):
		janitorDoorwayBox.set_visible(true)
		janitorDoorwayVisible = true
	if PlayerGlobal.inShootingRange and carnivalMusic.playing:
		musicTime = carnivalMusic.get_playback_position()
		carnivalMusic.stop()
	else:
		if !carnivalMusic.playing:
			carnivalMusic.play(musicTime)
	if PlayerGlobal.isBlackout:
		mainLight.set_visible(false)
	else:
		mainLight.set_visible(true)
