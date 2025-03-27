extends Node2D

func _process(delta: float) -> void:
	if GamesGlobal.enemiesKilled == 3:
		queue_free()
