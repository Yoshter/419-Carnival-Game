extends Area3D
@onready var Vent_Thud_Trigger_Shape = $CollisionShape3D
@onready var thud = $Thud
var thudCount : int = 0

#I don't like GD script cole please do this for me thanks
#I want this thud sound to play when the player enters the collision shape
#it CANT be that hard

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and thudCount == 0:
		thud.play(0.0)
		thudCount += 1
