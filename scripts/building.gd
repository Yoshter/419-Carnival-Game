extends Node2D

@onready var scoreSound: AudioStreamPlayer = $scoreSound
@onready var ticketGetSound: AudioStreamPlayer = $ticketGet
@onready var animation: AnimatedSprite2D = $animation
@onready var buildingSprite: Sprite2D = $Building
@onready var deathbox = $deathbox
@onready var deathSound: AudioStreamPlayer = $deathSound

func _on_deathbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		animation.set_visible(true)
		deathSound.play(0.0)
		animation.play("explosion")
		buildingSprite.set_visible(false)
		body.die()

func _on_score_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		if !body.isDead:
			deathSound.play(0.0)
			animation.set_visible(true)
			animation.play("explosion")
			buildingSprite.set_visible(false)
			deathbox.monitoring = false
			scoreSound.play(0.0)
			GamesGlobal.ufoScoreUp()
		if !body.isDead && GamesGlobal.ufoScore == 10:
			ticketGetSound.play()
			
