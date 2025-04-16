extends Node3D
@onready var doorBox: CSGBox3D = $CSGBox3D

func _process(delta: float) -> void:
	if PlayerGlobal.isBlackout:
		doorBox.position.y += 4.5
	else:
		doorBox.position.y = 0.0
