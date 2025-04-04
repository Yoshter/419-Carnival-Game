extends Control

@onready var winMenu: Control = $winMenu
@onready var startButton: Button = $startButton

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("tower"):
		startButton.set_visible(false)
		winMenu.set_visible(true)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/minigameScenes/towerCrash/w1c1.tscn")

func _on_prize_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-25.082,1.444,-58.956)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
