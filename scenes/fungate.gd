extends Node3D

@export var itemToCheck : String 
@onready var sprite1: AnimatedSprite3D = $sprite1
@onready var sprite2: AnimatedSprite3D = $sprite2
@onready var topSprite: Sprite3D = $topSprite
@onready var gateBody: CollisionShape3D = $StaticBody3D/CollisionShape3D
var isDown : bool = false

func _on_pass_check_area_body_entered(body: Node3D) -> void:
	print("in")
	if body.is_in_group("player"):
		print("player")
		if ItemsGlobal.checkItem(itemToCheck) and !isDown:
			gateBody.call_deferred("set_disabled", true)
			goDown()
			
		else:
			print("failed")

func goDown() -> void:
	topSprite.set_visible(false)
	sprite1.play("default")
	sprite2.play("default")
	#gateBody.disabled = true
	isDown = true
