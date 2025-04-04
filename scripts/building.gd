extends Node2D

@onready var scoreSound: AudioStreamPlayer = $scoreSound
@onready var ticketGetSound: AudioStreamPlayer = $ticketGet

func _on_deathbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		body.die()

func _on_score_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		if !body.isDead:
			scoreSound.play(0.0)
			GamesGlobal.ufoScoreUp()
		if !body.isDead && GamesGlobal.ufoScore == 10:
			ticketGetSound.play()
			
