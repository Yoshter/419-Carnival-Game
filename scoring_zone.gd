extends Area2D


@export var reqPowMax = 0
@export var reqPowMin = 100

@onready var successMusic: AudioStreamPlayer = $successMusic


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		if body.power > reqPowMin and body.power < reqPowMax:
			successMusic.play(0.0)
