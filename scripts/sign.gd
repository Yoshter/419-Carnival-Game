extends Node3D

@export var signNum : int = 1

@onready var thisway: Sprite3D = $thisway
@onready var hurry: Sprite3D = $hurry
@onready var almostat: Sprite3D = $almostat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setSign()

func setSign() -> void:
	match signNum:
		1:
			thisway.set_visible(true)
		2:
			hurry.set_visible(true)
		3:
			almostat.set_visible(true)
