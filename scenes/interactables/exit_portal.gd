extends Node3D

func _on_portal_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.needsTeleport = true
		PlayerGlobal.newPosition = Vector3(84.857,1.762,-68.14)
		PlayerGlobal.newRotation = rad_to_deg(-23)
		PlayerGlobal.isEndingSequence = true
		get_tree().change_scene_to_file.call_deferred("res://scenes/outsideFinale.tscn")
