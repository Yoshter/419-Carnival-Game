extends Node3D

@export var itemToCheck : String 
@onready var sprite1: AnimatedSprite3D = $sprite1
@onready var sprite2: AnimatedSprite3D = $sprite2
@onready var topSprite: Sprite3D = $topSprite
@onready var gateBody: CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var gateDownTimer: Timer = $gateDownTimer
var isDown : bool = false
var checkedPass : bool = false
@onready var gateOpenSound: AudioStreamPlayer3D = $gateOpenSound
@onready var gateDeniedSound: AudioStreamPlayer3D = $gateDeniedSound

func _on_pass_check_area_body_entered(body: Node3D) -> void:
	print("in")
	if body.is_in_group("player"):
		print("player")
		if ItemsGlobal.checkItem(itemToCheck) and !isDown:
			goDown()
		else:
			if !isDown and !checkedPass:
				gateDeniedSound.play(0.0)
				checkedPass = true

func _on_pass_check_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		checkedPass = false

func goDown() -> void:
	gateOpenSound.play(0.0)
	checkedPass = true
	topSprite.set_visible(false)
	sprite1.play("default")
	sprite2.play("default")
	#gateBody.disabled = true
	isDown = true
	gateDownTimer.start()

func _on_gate_down_timer_timeout() -> void:
	gateBody.call_deferred("set_disabled", true)
