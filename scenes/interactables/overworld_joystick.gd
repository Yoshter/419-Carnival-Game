extends Node3D

var inArea : bool = false
var isVisible : bool = true
@onready var pickUpArea: Area3D = $pickUpArea

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if isVisible:
		if ItemsGlobal.checkItem("joystick"):
			queue_free()
	
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			ItemsGlobal.giveItem("joystick")
			queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inArea = false
