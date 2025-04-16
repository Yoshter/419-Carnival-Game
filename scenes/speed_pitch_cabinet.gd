extends Node3D

var canPlay = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canPlay and Input.is_action_pressed("ui_accept") and ItemsGlobal.checkItem("speedPitchToken"):
		get_tree().change_scene_to_file("res://scenes/minigameScenes/speedPitch/speed_pitch.tscn")

func _on_game_portal_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if ItemsGlobal.checkItem("speedPitchToken"):
			PlayerGlobal.setCanInteract(true)
			canPlay = true

func _on_game_portal_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		if ItemsGlobal.checkItem("speedPitchToken"):
			PlayerGlobal.setCanInteract(false)
			canPlay = false
