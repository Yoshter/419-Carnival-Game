extends Node3D
@onready var red: Sprite3D = $"Target Sprites/Red"
@onready var blue: Sprite3D = $"Target Sprites/Blue"
@onready var purple: Sprite3D = $"Target Sprites/Purple"
@onready var animation: AnimationPlayer = $animation
@onready var delayTimer: Timer = $delayTimer

@onready var targetBody: CollisionShape3D = $CollisionShape3D

@export var targetLevel : int = 1
var targetScore : int = 0

func _ready() -> void:
	match targetLevel:
		1:
			targetScore = 50
			red.set_visible(true)
		2:
			targetScore = 100
			blue.set_visible(true)
		3:
			targetScore = 150
			purple.set_visible(true)

func score() -> void:
	GamesGlobal.shootingRangeScore += targetScore
	targetBody.disabled = true
	animation.play("fall_down")
	delayTimer.start()

func _on_delay_timer_timeout() -> void:
	targetBody.disabled = false
	animation.play("backUp")
