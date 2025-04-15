extends Area2D

@export var reqPowMax = 0
@export var reqPowMin = 100

@onready var successMusic: AudioStreamPlayer = $successMusic

func _on_body_entered(body: Node2D) -> void:
	print("whomp")
	if body.is_in_group("ball"):
		print("hello")
		print(body.power)
		if body.power > reqPowMin and body.power < reqPowMax:
			successMusic.play(0.0)
			body.queue_free()
			print("win")
		else:
			print("fail")
