extends Node3D
@onready var boardBreak = $BoardBreak

var inArea : bool = false

func _process(delta: float) -> void:
	if inArea:
		if ItemsGlobal.checkItem("saw") and Input.is_action_pressed("ui_accept"):
			boardBreak.play() #Not working
			queue_free()

func _on_board_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = true

func _on_board_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
