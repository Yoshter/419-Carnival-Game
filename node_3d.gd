extends Node3D

var inArea : bool = true
var hasPlayed : bool = false
@onready var finaleTimer: Timer = $finaleTimer
@onready var endCreditsAudio: AudioStreamPlayer = $endCredits

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.camMove()
		finaleTimer.start()
		if !hasPlayed:
			endCreditsAudio.play(0.0)
			hasPlayed = true
		print(endCreditsAudio.is_playing)
		PlayerGlobal.isDeaf = true

func _on_finale_timer_timeout() -> void:
	PlayerGlobal.beatCARN = true
	#endCreditsAudio.play(0.0)
