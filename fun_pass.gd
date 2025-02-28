extends Node3D

var inArea : bool = false
@onready var Light : SpotLight3D = $SpotLight3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			ItemsGlobal.giveItem("funPassLevel2")
			queue_free()

func _on_light_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = true
		Light.set_visible(inArea)

func _on_light_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
		Light.set_visible(inArea)
