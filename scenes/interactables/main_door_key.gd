extends Node3D

var inArea : bool = false
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _process(delta: float) -> void:
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			ItemsGlobal.giveItem("mainDoorKey")
			PlayerGlobal.setCanInteract(false)
			queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = true
		PlayerGlobal.setCanInteract(true)

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
		PlayerGlobal.setCanInteract(false)
