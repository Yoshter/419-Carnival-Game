extends Node3D

var inArea : bool = false
@onready var fixNoise: AudioStreamPlayer3D = $FixNoise

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
	print("hello")
	fixNoise.play(0.0)
	PlayerGlobal.isBlackout = false
	PlayerGlobal.afterBlackout = true
	PlayerGlobal.setCanInteract(false)
	print("fix/ should be 5" + str(DialogueGlobal.danEncCount))
	if DialogueGlobal.danEncCount == 5:
			DialogueGlobal.addToEncCount("dan")
			DialogueGlobal.objEncCount +=1
			print(DialogueGlobal.danEncCount)
			print("should be 6"+ str(DialogueGlobal.danEncCount))
			print(DialogueGlobal.objEncCount)
			print("should be 11"+ str(DialogueGlobal.objEncCount))
	else:
			pass
			#print("fail" + str(DialogueGlobal.danEncCount))
			#print("fail" + str(DialogueGlobal.danEncCount))
	
	
