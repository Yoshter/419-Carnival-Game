extends Control

@onready var winMenu: Control = $winMenu
@onready var startButton: Button = $startButton
@onready var winSound = $winSound
var hasWon: bool = false

func _process(delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if GamesGlobal.checkBeatGame("tower") and !hasWon:
		startButton.set_visible(false)
		winSound.play(0.0)
		hasWon = true
		winMenu.set_visible(true)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/minigameScenes/towerCrash/w1c1.tscn")

func _on_prize_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26.36,1.266,-51.17)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
