extends Node2D

func _process(delta: float) -> void:
	if GamesGlobal.enemiesKilled >= 4:
		GamesGlobal.towerBeat = true
		get_tree().change_scene_to_file.call_deferred("res://scenes/minigameScenes/towerCrash/tower_main_menu.tscn")
