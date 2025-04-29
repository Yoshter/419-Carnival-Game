extends Control

@onready var winMenu: Control = $winMenu
@onready var startButton: Button = $startButton
@onready var winSound = $winSound
var hasWon: bool = false
@onready var quitButton: Button = $quitButton

func _process(delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if GamesGlobal.checkBeatGame("tower") and !ItemsGlobal.checkItem("towerTicket"):
		startButton.set_visible(false)
		winSound.play(0.0)
		winMenu.set_visible(true)
	else:
		GamesGlobal.enemiesKilled = 0
		startButton.set_visible(true)
		quitButton.set_visible(true)
		winMenu.set_visible(false)
	print(hasWon)
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/minigameScenes/towerCrash/w1c1.tscn")

func _on_prize_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26.36,1.266,-51.17)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")

func _on_quit_b_utton_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-26.36,1.266,-51.17)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
