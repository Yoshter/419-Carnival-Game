extends Node3D
var wantsToTalk
@onready var talkBox : Area3D = $talkBox
@onready var talkLight: SpotLight3D = $talkLight
var hasTalkedTo : bool = false
var bodySafe : Node3D
var inArea : bool = false
var carnie1SpokenTo : bool = false
var carnie2SpokenTo : bool = false
var carnie3SpokenTo : bool = false
var carnie4SpokenTo : bool = false
var carnie7SpokenTo : bool = false
@onready var mainDoorKey: Node3D = $mainDoorKeyPickUpArea

func _process(delta: float) -> void:
	if inArea:
		
		if Input.is_action_pressed("ui_accept"):
			#print(DialogueGlobal.danEncCount)
			match DialogueGlobal.objEncCount:
				1:
					if !carnie1SpokenTo:
						DialogueGlobal.objEncCount += 1
						carnie1SpokenTo = true
				3:
					if !carnie2SpokenTo:
						DialogueGlobal.objEncCount += 1
						carnie2SpokenTo = true
				5:
					if !carnie3SpokenTo:
						DialogueGlobal.objEncCount += 1
						carnie3SpokenTo = true
				6:
					if !carnie7SpokenTo:
						mainDoorKey.set_visible(true)
						mainDoorKey.monitoring = true
						mainDoorKey.monitorable = true
						carnie7SpokenTo = true
				_:
					pass
	if PlayerGlobal.isBlackout:
		talkLight.set_visible(false)

func _on_talk_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !PlayerGlobal.inUI:
		if !hasTalkedTo:
			hasTalkedTo = true
			#DialogueGlobal.objEncCount
		inArea = true
		PlayerGlobal.setIsTalkingTo("dan")
		PlayerGlobal.setCanInteract(true)
		if !PlayerGlobal.isBlackout:
			talkLight.set_visible(true)
		body.canTalk = true

func _on_talk_box_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
		PlayerGlobal.setCanInteract(false)
		PlayerGlobal.inUI = false
		ItemsGlobal.showItemUI = false
		talkLight.set_visible(false)
		body.canTalk = false
