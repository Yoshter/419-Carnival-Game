extends Node3D
@onready var doorBox: CSGBox3D = $CSGBox3D
@onready var animation: AnimatedSprite3D = $animation
@onready var animation2: AnimatedSprite3D = $animation2

func _process(delta: float) -> void:
	if PlayerGlobal.isBlackout:
		doorBox.position.y += 6.925
		animation.play("unlocked")
		animation2.play("unlocked")
	if !PlayerGlobal.isBlackout and !PlayerGlobal.afterBlackout:
		doorBox.position.y = 2.425
		animation.play("locked")
		animation2.play("locked")
	if PlayerGlobal.afterBlackout:
		doorBox.position.y = 6.0
		animation.play("locked")
		animation2.play("locked")
