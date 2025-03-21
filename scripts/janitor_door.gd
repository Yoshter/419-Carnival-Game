extends Node3D

@onready var doorBox: CSGBox3D = $doorBox

@onready var unlockArea: Area3D = $unlockArea
var inArea : bool = false

func _process(delta: float) -> void:
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			queue_free()

func _on_unlock_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = true

func _on_unlock_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
