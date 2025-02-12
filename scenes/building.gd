extends Node2D

func _on_deathbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		body.die()



func _on_score_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		GamesGlobal.ufoScoreUp()
