extends Node3D

var inArea : bool = false

func _process(delta: float) -> void:
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			ItemsGlobal.giveItem("janitorsKey")
			PlayerGlobal.setCanInteract(false)
			queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inArea = false
