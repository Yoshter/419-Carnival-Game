extends Node2D

func _on_death_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ufoPlayer"):
		body.die()
