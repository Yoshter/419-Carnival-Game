extends Node3D
var wantsToTalk
@onready var talkBox : Area3D = $talkBox
@onready var talkLight: SpotLight3D = $talkLight

var bodySafe : Node3D

func _on_talk_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !PlayerGlobal.inUI:
		PlayerGlobal.setIsTalkingTo("dan")
		
		talkLight.set_visible(true)
		body.canTalk = true

func _on_talk_box_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		talkLight.set_visible(false)
		body.canTalk = false
