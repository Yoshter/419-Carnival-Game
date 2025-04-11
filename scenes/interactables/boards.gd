extends Node3D
@onready var boardBreak: AudioStreamPlayer3D = $boardBreakSound

var inArea : bool = false

func _process(delta: float) -> void:
	if inArea:
		if ItemsGlobal.checkItem("saw") and Input.is_action_pressed("ui_accept"):
			boardBreak.play(0.0) #Not working
			PlayerGlobal.setCanInteract(false)
			queue_free()

func _on_board_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if ItemsGlobal.checkItem("saw"):
			PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_board_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		if ItemsGlobal.checkItem("saw"):
			PlayerGlobal.setCanInteract(false)
		inArea = false
