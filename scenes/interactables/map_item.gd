extends Node3D

var inArea : bool = false
var isVisible : bool = true

func _process(delta: float) -> void:
	if isVisible:
		if ItemsGlobal.checkItem("map"):
			queue_free()
	
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			ItemsGlobal.giveItem("map")
			queue_free()

func _on_pick_up_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_pick_up_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inArea = false
