extends Node3D

var inArea : bool = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.camMove()
