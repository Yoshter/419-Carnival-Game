extends Node3D

@onready var janitorDoorwayBox: CSGBox3D = $ground/mainarea/mainTentCyl/janitorDoorway
var janitorDoorwayVisible : bool = false
@onready var carnivalMusic: AudioStreamPlayer3D = $"audioSpeakers/Carnival music"
var musicTime : float 
@onready var mainLight: OmniLight3D = $Lights/OmniLight3D4
@onready var rain_thunder: AudioStreamPlayer3D = $"audioSpeakers/Rain + Thunder"
@onready var quiet_rain: AudioStreamPlayer3D = $QuietRain


func _process(delta: float) -> void:
	if PlayerGlobal.isBlackout:
		carnivalMusic.stop()
		quiet_rain.stop()
		if !rain_thunder.playing:
			rain_thunder.play(0.0)
	if !PlayerGlobal.isBlackout:
		rain_thunder.stop()
		if !quiet_rain.playing:
			quiet_rain.play(0.0)
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
