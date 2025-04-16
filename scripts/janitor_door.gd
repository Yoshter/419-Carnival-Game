extends Node3D

@onready var door_box = $doorBox
@export var doorType: String = "janitor"
var keyToCheck: String = "null"

@onready var unlockArea: Area3D = $unlockArea
var inArea : bool = false

func _ready() -> void:
	match doorType:
		"janitor":
			keyToCheck = "janitorsKey"
		"mainDoor":
			keyToCheck = "mainDoorKey"
func _process(delta: float) -> void:
	if inArea:
		if Input.is_action_pressed("ui_accept"):
			queue_free()

func _on_unlock_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and ItemsGlobal.checkItem(keyToCheck):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_unlock_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and ItemsGlobal.checkItem(keyToCheck):
		PlayerGlobal.setCanInteract(false)
		inArea = false
