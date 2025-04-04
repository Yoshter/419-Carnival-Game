extends Node3D

func _on_shooting_range_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.inShootingRange = true

func _on_shooting_range_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.inShootingRange = false
