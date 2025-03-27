extends Control

@onready var winMenu: Control = $winMenu
@onready var startButton: Button = $startButton

func _process(delta: float) -> void:
	if GamesGlobal.checkBeatGame("tower"):
		startButton.set_visible(false)
		winMenu.set_visible(true)
