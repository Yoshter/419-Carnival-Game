extends Node3D
@onready var doorBox: CSGBox3D = $CSGBox3D

func _process(delta: float) -> void:
	if PlayerGlobal.isBlackout:
		doorBox.position.y += 6.925
	if !PlayerGlobal.isBlackout and !PlayerGlobal.afterBlackout:
		doorBox.position.y = 2.425
	if PlayerGlobal.afterBlackout:
		doorBox.position.y = 6.0
