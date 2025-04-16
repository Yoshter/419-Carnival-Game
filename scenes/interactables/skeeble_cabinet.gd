extends Node3D
var canPlay : bool = false

func _process(delta: float) -> void:
	if canPlay and Input.is_action_pressed("ui_accept") and ItemsGlobal.checkItem("skeebleToken"):
		get_tree().change_scene_to_file("res://scenes/minigameScenes/skeeble2/skeeble_2.tscn")

func _on_game_portal_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if ItemsGlobal.checkItem("skeebleToken"):
			PlayerGlobal.setCanInteract(true)
			canPlay = true

func _on_game_portal_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		if ItemsGlobal.checkItem("skeebleToken"):
			PlayerGlobal.setCanInteract(false)
			canPlay = false
			
