extends RigidBody2D

func _physics_process(delta: float) -> void:
	position.y += delta * 2
	
