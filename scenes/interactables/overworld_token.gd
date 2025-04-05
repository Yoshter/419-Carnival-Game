extends StaticBody3D

@export var tokenString : String
@onready var shootingRangeTokenSprite: Sprite3D = $overworldToken/shootingRangeToken
@onready var skeebleTokenSprite: Sprite3D = $overworldToken/skeebleToken
@onready var towerTokenSprite: Sprite3D = $overworldToken/towerToken

@onready var pickUpArea: Area3D = $pickUpArea

var inArea : bool = false
var isFallen : bool = false

func _ready() -> void:
	match tokenString:
		"tower":
			towerTokenSprite.set_visible(true)
		"shootingRange":
			shootingRangeTokenSprite.set_visible(true)
		"skeeble":
			skeebleTokenSprite.set_visible(true)

func process() -> void:
	if inArea:
		if Input.is_action_pressed("interact"):
			match tokenString:
				"tower":
					ItemsGlobal.giveItem("towerToken")
				"shootingRange":
					ItemsGlobal.giveItem("rangeToken")
				"skeeble":
					ItemsGlobal.giveItem("skeebleToken")

func fall() -> void:
	if !isFallen:
		pickUpArea.set_visible(true)
		isFallen = true
		match tokenString:
			"tower":
				global_position.y -= 4.5
			"shootingRange":
				global_position.y -= 3.0
			"skeeble":
				global_position.y -= 8
		#global_position.y -= 8

func _on_pick_up_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_pick_up_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inArea = false
