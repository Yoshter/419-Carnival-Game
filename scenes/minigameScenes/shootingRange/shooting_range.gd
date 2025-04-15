extends Node3D

var inGameBoothArea : bool = false
var shootingRangeStarted = false
@onready var shootingRangeTimer: Timer = $shootingRangeTimer

func _process(delta: float) -> void:
	if inGameBoothArea and ItemsGlobal.checkItem("rangeToken"):
		PlayerGlobal.setCanInteract(true)
		if Input.is_action_pressed("ui_accept"):
			shootingRangeTimer.start()
			shootingRangeStarted = true

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
	if GamesGlobal.shootingRangeScore >= 1500:
		GamesGlobal.rangeBeat = true
 
