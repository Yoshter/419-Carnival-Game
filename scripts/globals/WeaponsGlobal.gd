extends Node

var currentWeapon : String = ""
var hasPipe : bool = false
var hasBBGun : bool = false
var isCharging : bool = false
var isCharged : bool = false
var isSwinging : bool = false
var saveChargeNum : float = 0.00

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateWeapons() -> void:
	hasPipe = ItemsGlobal.checkItem("pipe")
	hasBBGun = ItemsGlobal.checkItem("bbGun")

#custom funcs
func setCurrentWeapon(newCurrentWeapon : String) -> void:
	currentWeapon = newCurrentWeapon

func getCurrentWeapon() -> String:
	return currentWeapon
