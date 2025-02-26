extends Node3D

@export var itemToCheck : String 

func _on_pass_check_area_body_entered(body: Node3D) -> void:
	print("in")
	if body.is_in_group("player"):
		print("player")
		if ItemsGlobal.checkItem(itemToCheck):
			queue_free()
		else:
			print("failed")
