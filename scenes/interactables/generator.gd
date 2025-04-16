extends Node3D

var inArea : bool = false

func _process(delta: float) -> void:
	if inArea:
		if Input.is_action_pressed("ui_accept") and PlayerGlobal.isBlackout:
			fix()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inArea = false

func fix() -> void:
	PlayerGlobal.isBlackout = false
	PlayerGlobal.setCanInteract(false)
	print(DialogueGlobal.danEncCount)
	if DialogueGlobal.danEncCount == 9 and DialogueGlobal.objEncCount == 9:
		DialogueGlobal.danEncCount = 10
		DialogueGlobal.objEncCount = 10
		print(DialogueGlobal.danEncCount)
	else:
		print("fail" + str(DialogueGlobal.danEncCount))
		#print("fail" + str(DialogueGlobal.danEncCount))
	
	
