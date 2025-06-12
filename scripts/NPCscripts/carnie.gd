extends Node3D
var wantsToTalk
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var talkBox : Area3D = $talkBox
@onready var talkLight: SpotLight3D = $talkLight
@onready var powerDown = $"../PowerDown"
var hasTalkedTo : bool = false
var bodySafe : Node3D
var inArea : bool = false
var isPowerDown : bool = false
var isSpeaking : bool = false
var isBeingTalkedTo : bool = false
var carnie1SpokenTo : bool = false
var carnie2SpokenTo : bool = false
var carnie3SpokenTo : bool = false
var carnie4SpokenTo : bool = false
var carnie7SpokenTo: bool = false
var carnie9SpokenTo : bool = false
@onready var mainDoorKey: Node3D = $mainDoorKeyPickUpArea
@onready var carnieVoice: AudioStreamPlayer3D = $carnieVoice
@onready var thunder_jumpscare: AudioStreamPlayer = $"../Thunder Jumpscare"
@onready var carnieSprite: AnimatedSprite3D = $carnieSprite
@onready var waveDelay: Timer = $waveDelay
var isWaving : bool = false

func _process(delta: float) -> void:
	#if PlayerGlobal.checkIsTalkingTo() == "dan" and !carnieVoice.is_playing:
	if isBeingTalkedTo:
		if !isWaving:
			carnieSprite.play("talking")
			if waveDelay.is_stopped():
				waveDelay.start()
		if !isSpeaking:
			#carnieVoice.play(0.0)
			isSpeaking = true
	else:
		carnieSprite.play("default")

	if inArea:
		if Input.is_action_pressed("ui_accept"):
			isBeingTalkedTo = true
			#print(DialogueGlobal.danEncCount)
			match DialogueGlobal.danEncCount:
				5:
					if !PlayerGlobal.isBlackout:
						PlayerGlobal.isBlackout = true
						if !isPowerDown:
							isPowerDown = true
							powerDown.play(0.0)
							thunder_jumpscare.play(0.0)
				6:
					if !carnie7SpokenTo:
						mainDoorKey.set_visible(true)
						mainDoorKey.monitoring = true
						mainDoorKey.monitorable = true
						carnie7SpokenTo = true
				_:
					pass
			
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
				9:
					if !carnie9SpokenTo:
						DialogueGlobal.objEncCount += 1
						carnie9SpokenTo = false
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
		PlayerGlobal.setIsTalkingTo("CARN-E")
		PlayerGlobal.setCanInteract(true)
		if !PlayerGlobal.isBlackout:
			talkLight.set_visible(true)
		body.canTalk = true

func _on_talk_box_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
		PlayerGlobal.setCanInteract(false)
		PlayerGlobal.inUI = false
		PlayerGlobal.isTalking = false
		ItemsGlobal.showItemUI = false
		talkLight.set_visible(false)
		isSpeaking = false
		isBeingTalkedTo = false
		isWaving = false
		body.canTalk = false
		if DialogueGlobal.danEncCount == 6:
			DialogueGlobal.addToEncCount("CARN-E")

func _on_wave_delay_timeout() -> void:
	carnieSprite.stop()
	carnieSprite.play("waving")
	isWaving = true

func _on_surprise_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !PlayerGlobal.inUI:
		print(DialogueGlobal.danEncCount)
		if DialogueGlobal.danEncCount == 7:
			isBeingTalkedTo = true
			PlayerGlobal.setIsTalking(true)
			PlayerGlobal.setIsTalkingTo("CARN-E")
			body.fallTimer.start()
