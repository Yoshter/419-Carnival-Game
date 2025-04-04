extends Node3D

@export var targetLevel : int = 1
var targetScore : int = 0

func _ready() -> void:
	match targetLevel:
		1:
			targetScore = 50
		2:
			targetScore = 100
		3:
			targetScore = 150

func score() -> void:
	GamesGlobal.shootingRangeScore += targetScore
