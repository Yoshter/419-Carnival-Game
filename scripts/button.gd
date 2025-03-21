extends Button

@export var nextScene : String
@export var isQuit : bool = false

#Custom funcs
func changeSceneTo(nextScene) -> void:
	
	get_tree().change_scene_to_file(nextScene)

func _on_pressed() -> void:
	GamesGlobal.ufoScoreReset()
	if isQuit:
		PlayerGlobal.needsTeleport = true
		PlayerGlobal.newPosition = Vector3(-107.4,1.266,-152.4)
	changeSceneTo(nextScene)
