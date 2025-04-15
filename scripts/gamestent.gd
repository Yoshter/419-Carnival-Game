extends Node3D

@onready var janitorDoorwayBox: CSGBox3D = $ground/mainarea/mainTentCyl/janitorDoorway
var janitorDoorwayVisible : bool = false
@onready var carnivalMusic: AudioStreamPlayer3D = $"audioSpeakers/Carnival music"
var musicTime : float 

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
