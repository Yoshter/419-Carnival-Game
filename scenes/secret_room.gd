extends Node3D
@onready var light1: SpotLight3D = $SpotLight3D
@onready var light2: SpotLight3D = $SpotLight3D2

func _process(delta: float) -> void:
	if !PlayerGlobal.isBlackout:
		light1.set_visible(true)
		light2.set_visible(true)
	else:
		light1.set_visible(false)
		light2.set_visible(false)
