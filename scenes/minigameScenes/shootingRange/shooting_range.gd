extends Node3D

var inGameBoothArea : bool = false
var shootingRangeStarted = false
@onready var shootingRangeTimer: Timer = $shootingRangeTimer
@onready var csgBarrier: CSGBox3D = $barrier/barrier/CSGBox3D5
@onready var barrier: CSGBox3D = $barrier/barrier
@onready var lights: Node3D = $lights
@onready var music: AudioStreamPlayer3D = $music
@onready var win_sound = $WinSound

func _process(delta: float) -> void:
	if PlayerGlobal.isBlackout:
		lights.set_visible(false)
		music.stop()
	else:
		lights.set_visible(true)
	if !shootingRangeTimer.is_stopped():
		GamesGlobal.shootingRangeTimeLeft = shootingRangeTimer.time_left
	if inGameBoothArea and ItemsGlobal.checkItem("rangeToken"):
		PlayerGlobal.setCanInteract(true)
		if Input.is_action_pressed("ui_accept"):
			music.play(0.0)
			barrier.set_visible(true)
			barrier.use_collision = true
			csgBarrier.use_collision = true 
			PlayerGlobal.setCanInteract(false)
			GamesGlobal.shootingRangeScore = 0
			shootingRangeTimer.start()
			shootingRangeStarted = true
			#print("womp" + str(csgBarrier.use_collision))

func _on_shooting_range_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.inShootingRange = true

func _on_shooting_range_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.inShootingRange = false

func _on_game_booth_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inGameBoothArea = true

func _on_game_booth_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inGameBoothArea = false

func _on_shooting_range_timer_timeout() -> void:
	if GamesGlobal.shootingRangeScore >= 2500:
		GamesGlobal.rangeBeat = true
		win_sound.play(0.0)
	music.stop()
	barrier.set_visible(false)
	barrier.use_collision = false
	csgBarrier.use_collision = false
 
