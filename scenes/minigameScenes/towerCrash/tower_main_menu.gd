extends Control

@onready var winMenu: Control = $winMenu
@onready var startButton: Button = $startButton
@onready var winSound : AudioStreamPlayer2D = $winSound
var hasWon: bool = false
@onready var quitButton: Button = $quitButton
var winSoundPlayed : bool = false
var updateCount : int = 0
@onready var menuMusic: AudioStreamPlayer2D = $MenuMusic
@onready var songDelay: Timer = $songDelay

func _process(delta: float) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if updateCount < 1:
		if GamesGlobal.checkBeatGame("tower") and !ItemsGlobal.checkItem("towerTicket") and !hasWon:
			hasWon = true
		if GamesGlobal.checkBeatGame("tower") and !ItemsGlobal.checkItem("towerTicket") and hasWon:
			print("winner")
			startButton.set_visible(false)
			winMenu.set_visible(true)
			GamesGlobal.enemiesKilled = 0
			print(winSound.playing)
			if !winSound.playing and !winSoundPlayed:
				menuMusic.volume_db = -90
				print("winnerbinner")
				winSound.play(0.0)
				winSoundPlayed = true
				songDelay.start()
		if GamesGlobal.checkBeatGame("tower") and !ItemsGlobal.checkItem("towerTicket") and !hasWon:
			GamesGlobal.enemiesKilled = 0
			startButton.set_visible(true)
			quitButton.set_visible(true)
			#winMenu.set_visible(false)
		#print(hasWon)
		updateCount += 1
	
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


func _on_song_delay_timeout() -> void:
	menuMusic.volume_db = 0
	menuMusic.play(0.0)
