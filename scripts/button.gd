extends Button

@export var nextScene : String
@export var isQuit : bool = false

#Custom funcs
func changeSceneTo() -> void:
	get_tree().change_scene_to_file(nextScene)

func _on_pressed() -> void:
	GamesGlobal.ufoScoreReset()
	if isQuit:
		if GamesGlobal.checkBeatGame("ufo"):
			PlayerGlobal.needsTeleport = true
			PlayerGlobal.newPosition = Vector3(-25.082,1.444,-58.956)
			get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
		else:
			PlayerGlobal.needsTeleport = true
			PlayerGlobal.newPosition = Vector3(-107.4,1.266,-152.4)
			get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
	else:
		changeSceneTo()
