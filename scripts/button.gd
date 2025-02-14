extends Button

@export var nextScene : String

#Custom funcs
func changeSceneTo(nextScene) -> void:
	get_tree().change_scene_to_file(nextScene)

func _on_pressed() -> void:
	changeSceneTo(nextScene)
